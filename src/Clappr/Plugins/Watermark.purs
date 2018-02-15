module Clappr.Plugins.Watermark where

import Prelude

import Clappr (NativeOptions, Plugin, NativeOptionsRow)
import Data.Array ((:))
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Data.Record.Builder (insert, build)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import watermark ∷ Plugin

data Position = TopLeft | TopRight | BottomRight | BottomLeft

type Options =
  { link ∷ Maybe String
  , position ∷ Position
  , url ∷ String
  }

setup
  ∷ ∀ r r'
  . RowLacks
      "watermark"
      (NativeOptionsRow
        ( "watermarkLink" ∷ Nullable String
        , "position" ∷ String
        | r ))
  ⇒ RowLacks
      "watermarkLink"
      (NativeOptionsRow (position ∷ String | r))
  ⇒ RowLacks "position" (NativeOptionsRow r)
  ⇒ Options
  → NativeOptions r
  → NativeOptions
      ( position ∷ String
      , watermarkLink ∷ Nullable String
      , watermark ∷ String
      | r )
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

