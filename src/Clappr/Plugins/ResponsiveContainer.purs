module Clappr.Plugins.ResponsiveContainer where

import Prelude

import Clappr (NativeOptionsRow, Plugin, NativeOptions)
import Data.Array ((:))
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import responsiveContainer ∷ Plugin

setup
  ∷ ∀ r r' r''
  . RowLacks "width" (NativeOptionsRow r)
  ⇒ RowLacks "height" (NativeOptionsRow (width ∷ Number | r))
  ⇒ { height ∷ Number, width ∷ Number }
  → NativeOptions r
  → NativeOptions (height ∷ Number, width ∷ Number | r)
setup { height, width } opts =
    let
      o = opts  { plugins = responsiveContainer : opts.plugins }
      o' = insert (SProxy ∷ SProxy "width") width o
    in
      insert (SProxy ∷ SProxy "height") height o'
