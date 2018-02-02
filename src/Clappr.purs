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

data Parent = ParentId String | Parent HTMLElement

type Options = { source ∷ String, parent ∷ Parent }

clappr ∷ ∀ eff. Options → Eff (clappr ∷ CLAPPR, exception ∷ EXCEPTION, dom ∷ DOM | eff) Clappr
clappr = runEffFn1 clapprImpl <<< toNativeOptions

type NativeOptions =
  { source ∷ String
  , parentId ∷ Nullable String
  , parent ∷ Nullable HTMLElement
  }

foreign import clapprImpl ∷ ∀ eff. EffFn1 (exception ∷ EXCEPTION, clappr ∷ CLAPPR, dom ∷ DOM | eff) NativeOptions Clappr

toNativeOptions ∷ Options → NativeOptions
toNativeOptions options =
  build parent { source: options.source }
 where
  _parentId = SProxy ∷ SProxy "parentId"
  _parent = SProxy ∷ SProxy "parent"
  parent = case options.parent of
    ParentId p → insert _parentId (toNullable (Just p)) <<< insert _parent (toNullable Nothing)
    Parent p → insert _parentId (toNullable Nothing) <<< insert _parent (toNullable (Just p))


