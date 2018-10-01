module Clappr.Plugins.ResponsiveContainer where

import Clappr (NativeOptionsRow, Plugin, NativeOptions) as Clappr
import Data.Array ((:))
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import responsiveContainer ∷ Clappr.Plugin

type NativeOptionsRow r = (height ∷ Number, width ∷ Number | r)

setup
  ∷ ∀ r
  . RowLacks "width" (Clappr.NativeOptionsRow r)
  ⇒ RowLacks "height" (Clappr.NativeOptionsRow (width ∷ Number | r))
  ⇒ { height ∷ Number, width ∷ Number }
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow r)
setup { height, width } opts =
    let
      o = opts  { plugins = responsiveContainer : opts.plugins }
      o' = insert (SProxy ∷ SProxy "width") width o
    in
      insert (SProxy ∷ SProxy "height") height o'
