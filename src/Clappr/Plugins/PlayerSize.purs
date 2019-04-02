module Clappr.Plugins.PlayerSize where

import Prelude

import Clappr (NativeOptions)
import Data.Number.Format (toString)
import Data.Variant (Variant, case_, expand, inj, on)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))

type Pct v = (pct :: Number | v)

_pct = SProxy :: SProxy "pct"

pct :: forall v. Number -> Variant (Pct v)
pct = inj _pct

type Px v = (px :: Number | v)
_px = SProxy :: SProxy "px"

px :: forall v. Number -> Variant (Px v)
px = inj _px

type Width = Variant (Pct (Px ()))

setup
  ∷ ∀ r
  . Lacks "width" r
  ⇒ Lacks "height" r
  ⇒ { height ∷ Variant (Px ()), width ∷ Width }
  → NativeOptions r
  → NativeOptions (height ∷ String, width ∷ String | r)
setup { height, width } opts =
  insert (SProxy ∷ SProxy "height") (render (expand height)) opts'
  where
  opts' = insert (SProxy ∷ SProxy "width") (render width) opts
  render = case_
    # on _pct (\n → toString n <> "%")
    # on _px (\n → toString n <> "px")
