module Clappr.Plugins.ClickToStop where

import Prelude

import Clappr (NativeOptions) as Clappr
import Clappr (Plugin)
import Data.Array ((:))
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (type (+))

foreign import clickToStop ∷ Plugin

type NativeOptionsRow r = (clickToStop ∷ Unit | r)

setup
  ∷ ∀ r
  . Lacks "clickToPause" r
  ⇒ Lacks "clickToStop" r
  ⇒ Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow + r)
setup opts =
  insert (SProxy ∷ SProxy "clickToStop") unit opts'
  where
    opts' = opts { plugins = clickToStop : opts.plugins }
