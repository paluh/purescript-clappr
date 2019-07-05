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

type NativeOptionsRow r = (clickToPlaybackControl ∷ Unit | r)

setup
  ∷ ∀ r
  . Lacks "clickToPlaybackControl" r
  ⇒ Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow + r)
setup opts =
  insert (SProxy ∷ SProxy "clickToPlaybackControl") unit opts'
  where
    opts' = opts { plugins = clickToPause : opts.plugins }
