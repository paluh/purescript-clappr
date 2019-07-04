module Clappr.Plugins.ClickToPause where

import Prelude

import Clappr (NativeOptions) as Clappr
import Clappr (Plugin)
import Data.Array ((:))
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (type (+))

foreign import clickToPause ∷ Plugin

type NativeOptionsRow r = (clickToPause ∷ Unit | r)

setup
  ∷ ∀ r
  . Lacks "clickToPause" r
  ⇒ Lacks "clickToStop" r
  ⇒ Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow + r)
setup opts =
  insert (SProxy ∷ SProxy "clickToPause") unit opts'
  where
    opts' = opts { plugins = clickToPause : opts.plugins }
