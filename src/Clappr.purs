module Clappr where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Prim.Row (class Lacks)
import Record (insert, set)
import Type.Prelude (SProxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.HTML (HTMLElement)

foreign import data Clappr ∷ Type
foreign import data Plugin ∷ Type
-- | Flash backend has some global initialization.
-- | We are caching instance on window level to
-- | force only single instance.
foreign import data FlashPlugin ∷ Type
foreign import flasHls ∷ Effect FlashPlugin
foreign import hls ∷ Plugin

toPlugin ∷ FlashPlugin → Plugin
toPlugin = unsafeCoerce

-- | This base config is reused by Pux/React bindings
type OptionsBase o =
  { autoPlay ∷ Boolean
  , baseUrl ∷ Maybe String
  , hideMediaControl ∷ Boolean
  , hlsjsConfig ∷ Maybe HlsjsConfig
  , hlsRecoverAttempts ∷ Maybe Int
  , mute ∷ Boolean
  , source ∷ String
  | o
  }

data Parent = ParentId String | Parent HTMLElement
-- | Change parent so it could be only HTMLElement
type Options = OptionsBase (parent ∷ Parent)

clappr ∷ ∀ r. NativeOptions r → Effect Clappr
clappr = runEffectFn1 clapprImpl

type HlsjsConfig =
  { debug ∷ Boolean
  , liveSyncDuration ∷ Int
  , maxBufferSize ∷ Int
  , maxBufferLength ∷ Int
  }

foreign import hlsjsDefaultConfig ∷ HlsjsConfig

type NativeOptionsRow r =
  ( autoPlay ∷ Boolean
  , baseUrl ∷ Nullable String
  , hideMediaControl ∷ Boolean
  , hlsjsConfig ∷ Nullable HlsjsConfig
  , hlsRecoverAttempts ∷ Nullable Int
  , mute ∷ Boolean
  , parentId ∷ Nullable String
  , parent ∷ Nullable HTMLElement
  , plugins ∷ Array Plugin
  , source ∷ String
  | r
  )
type NativeOptions r = Record (NativeOptionsRow r)

foreign import clapprImpl ∷ ∀ p. EffectFn1 (NativeOptions p) Clappr
toNativeOptions
  ∷ ∀ r
  . (Lacks "plugins" r)
  ⇒ (Lacks "parentId" r)
  ⇒ OptionsBase (parent ∷ Parent | r)
  → NativeOptions r
toNativeOptions options
  = insert (SProxy ∷ SProxy "plugins") []
  <<< parent
  <<< set (SProxy ∷ SProxy "baseUrl") (toNullable options.baseUrl)
  <<< set (SProxy ∷ SProxy "hlsjsConfig") (toNullable options.hlsjsConfig)
  <<< set (SProxy ∷ SProxy "hlsRecoverAttempts") (toNullable options.hlsRecoverAttempts)
  $ options
  where
    _parentId = SProxy ∷ SProxy "parentId"
    _parent = SProxy ∷ SProxy "parent"
    parent = case options.parent of
      ParentId p → insert _parentId (toNullable (Just p)) <<< set _parent (toNullable Nothing)
      Parent p → insert _parentId (toNullable Nothing) <<< set _parent (toNullable (Just p))

