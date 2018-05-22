module Clappr.Plugins.FlasHls where

import Prelude

import Clappr (NativeOptions, NativeOptionsRow, flasHls)
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Nullable (toNullable)
import Data.Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (class RowLacks)

setup
  ∷ ∀ r
  . RowLacks "flasHls" (NativeOptionsRow r)
  ⇒ String
  → NativeOptions r
  → NativeOptions (flasHls ∷ Unit | r)
setup baseUrl opts =
  let
    opts' = opts { plugins = flasHls : opts.plugins, baseUrl = toNullable $ Just baseUrl }
  in
    insert (SProxy ∷ SProxy "flasHls") unit opts'
