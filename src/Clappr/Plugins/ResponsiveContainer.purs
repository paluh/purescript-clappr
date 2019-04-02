module Clappr.Plugins.ResponsiveContainer where

import Clappr (NativeOptions, Plugin) as Clappr
import Data.Array ((:))
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))

foreign import responsiveContainer ∷ Clappr.Plugin

type NativeOptionsRow r = (height ∷ Number, width ∷ Number | r)

setup
  ∷ ∀ r
  . Lacks "width" r
  ⇒ Lacks "height" r
  ⇒ { height ∷ Number, width ∷ Number }
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow r)
setup { height, width } opts =
    let
      o = opts  { plugins = responsiveContainer : opts.plugins }
      o' = insert (SProxy ∷ SProxy "width") width o
    in
      insert (SProxy ∷ SProxy "height") height o'
