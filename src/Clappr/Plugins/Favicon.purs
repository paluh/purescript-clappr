module Clappr.Plugins.Favicon where

import Clappr (NativeOptions, Plugin)
import Data.Array ((:))
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(SProxy))

foreign import favicon ∷ Plugin

setup ∷ ∀ r
  . Lacks "changeFavicon" r
  ⇒ NativeOptions r
  → NativeOptions (changeFavicon ∷ Boolean | r)
setup opts =
  let opts' = opts { plugins = favicon : opts.plugins }
  in insert (SProxy ∷ SProxy "changeFavicon") true opts'

