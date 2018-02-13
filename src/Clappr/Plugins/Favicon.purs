module Clappr.Plugins.Favicon where

import Clappr (NativeOptions, Plugin, NativeOptionsRow)
import Data.Array ((:))
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(SProxy))

foreign import favicon ∷ Plugin

setup ∷ ∀ r
  . RowLacks "changeFavicon" (NativeOptionsRow r)
  ⇒ NativeOptions r
  → NativeOptions (changeFavicon ∷ Boolean | r)
setup opts =
  let opts' = opts { plugins = favicon : opts.plugins }
  in insert (SProxy ∷ SProxy "changeFavicon") true opts'

