module Clappr where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Uncurried (EffFn1, runEffFn1)
import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toNullable)
import Data.Record.Builder (build, insert)
import Type.Prelude (SProxy(..))

foreign import data Clappr ∷ Type
foreign import data CLAPPR ∷ Effect
foreign import data Plugin ∷ Type

-- | This base config is reused by Pux/React bindings
type OptionsBase o = { source ∷ String | o}

data Parent = ParentId String | Parent HTMLElement
-- | Change parent so it could be only HTMLElement
type Options = OptionsBase (parent ∷ Parent)

clappr ∷ ∀ eff r. NativeOptions r → Eff (clappr ∷ CLAPPR, exception ∷ EXCEPTION, dom ∷ DOM | eff) Clappr
clappr = runEffFn1 clapprImpl

-- | Same as above - Pux/React bindings
type NativeOptionsRowBase r =
    ( source ∷ String
    , plugins ∷ Array Plugin
    | r
    )

type NativeOptionsRow r =
  NativeOptionsRowBase
    ( parentId ∷ Nullable String
    , parent ∷ Nullable HTMLElement
    | r
    )
type NativeOptions r = Record (NativeOptionsRow r)

foreign import clapprImpl ∷ ∀ eff p. EffFn1 (exception ∷ EXCEPTION, clappr ∷ CLAPPR, dom ∷ DOM | eff) (NativeOptions p) Clappr

toNativeOptions ∷ Options → NativeOptions ()
toNativeOptions options =
  build parent { source: options.source, plugins: plugins }
 where
  _parentId = SProxy ∷ SProxy "parentId"
  _parent = SProxy ∷ SProxy "parent"
  parent = case options.parent of
    ParentId p → insert _parentId (toNullable (Just p)) <<< insert _parent (toNullable Nothing)
    Parent p → insert _parentId (toNullable Nothing) <<< insert _parent (toNullable (Just p))
  plugins = []


