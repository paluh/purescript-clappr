module Clappr.Plugins.Watermark where

import Prelude

import Clappr (NativeOptions, Plugin)
import Data.Array ((:))
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Prim.Row (class Lacks)
import Record.Builder (insert, build)
import Type.Prelude (SProxy(..))

foreign import watermark ∷ Plugin

data Position = TopLeft | TopRight | BottomRight | BottomLeft

type Options =
  { link ∷ Maybe String
  , position ∷ Position
  , url ∷ String
  }

setup
  ∷ ∀ r
  . Lacks "watermark" r
  ⇒ Lacks "watermarkLink" r
  ⇒ Lacks "position" r
  ⇒ Options
  → NativeOptions r
  → NativeOptions
      ( position ∷ String
      , watermarkLink ∷ Nullable String
      , watermark ∷ String
      | r
      )
setup wOpts opts
  = build builder $ opts { plugins = watermark : opts.plugins }
 where
  builder
    = insert (SProxy ∷ SProxy "watermark") wOpts.url
    <<< insert (SProxy ∷ SProxy "watermarkLink") (toNullable wOpts.link)
    <<< insert (SProxy ∷ SProxy "position") (serPosition wOpts.position)

  serPosition TopLeft = "top-left"
  serPosition TopRight = "top-right"
  serPosition BottomRight = "bottom-right"
  serPosition BottomLeft = "bottom-left"

