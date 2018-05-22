module Clappr.Plugins.Streamroot where

import Prelude

import Clappr (NativeOptions, NativeOptionsRow, Plugin, HlsjsConfig)
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.Compat (EffFnAff, fromEffFnAff)
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toNullable)
import Data.Record (insert)
import Data.Tuple (Tuple(..))
import Network.HTTP.Affjax (AJAX)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import flashHls ∷ Plugin
foreign import hls ∷ Plugin

foreign import streamrootHlsjsImpl ∷ ∀ eff. String → EffFnAff (ajax ∷ AJAX | eff) Plugin

streamrootHlsjs ∷ ∀ eff. String → Aff (ajax ∷ AJAX | eff) Plugin
streamrootHlsjs = fromEffFnAff <<< streamrootHlsjsImpl

data FetchedBeforeLoad = SecondsPrebuffereddBeforeLoad Int | FragmentsFetchedBeforeLoad Int

type DnaConfig =
  { fetchBeforeLoad ∷ Maybe FetchedBeforeLoad
  , property ∷ Maybe String
  }

type DnaNativeConfig =
  { fragmentsFetchedBeforeLoad ∷ Nullable Int
  , property ∷ Nullable String
  , secondsPrebuffereddBeforeLoad ∷ Nullable Int
  }

defaultDnaConfig ∷ DnaConfig
defaultDnaConfig = { property: Nothing, fetchBeforeLoad: Just (FragmentsFetchedBeforeLoad 3) }

setupHlsjs ∷ HlsjsConfig → HlsjsConfig
setupHlsjs hlsjsConfig =
  hlsjsConfig { maxBufferSize=0, maxBufferLength=30, liveSyncDuration=30 }

setup
  ∷ ∀ eff r
  . RowLacks "dnaConfig" (NativeOptionsRow r)
  ⇒ String
  → DnaConfig
  → NativeOptions r
  → Aff (ajax ∷ AJAX | eff) (NativeOptions (dnaConfig ∷ DnaNativeConfig | r))
setup key dnaConfig opts = do
  streamroot ← streamrootHlsjs key
  pure $ insert (SProxy ∷ SProxy "dnaConfig") dnaConfig' $ opts
    { plugins = streamroot : opts.plugins }
  where
  Tuple secondsPrebuffereddBeforeLoad fragmentsFetchedBeforeLoad = case dnaConfig.fetchBeforeLoad of
   Just (SecondsPrebuffereddBeforeLoad s) →
    Tuple (toNullable (Just s)) (toNullable Nothing)
   Just (FragmentsFetchedBeforeLoad f) →
    Tuple (toNullable Nothing) (toNullable (Just f))
   Nothing →
    Tuple (toNullable Nothing) (toNullable Nothing)
  dnaConfig' =
    { fragmentsFetchedBeforeLoad
    , property: toNullable dnaConfig.property
    , secondsPrebuffereddBeforeLoad
    }
