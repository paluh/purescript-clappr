module Clappr.Plugins.Thumbnails where

import Prelude

import Clappr (NativeOptionsRow, Plugin, NativeOptions) as Clappr
import Data.Array ((:))
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import thumbnails ∷ Clappr.Plugin

type Thumbnail = { time ∷ Int, url ∷ String }

type Options =
  { backdropHeight ∷ Maybe Int
  , spotlightHeight ∷ Maybe Int
  , thumbs ∷ Array Thumbnail
  }

type NativeOptions =
  { backdropHeight ∷ Nullable Int
  , spotlightHeight ∷ Nullable Int
  , thumbs ∷ Array Thumbnail
  }

type NativeOptionsRow r = (scrubThumbnails ∷ NativeOptions | r)

setup
  ∷ ∀ r
  . RowLacks "scrubThumbnails" (Clappr.NativeOptionsRow r)
  ⇒ Options
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow r)
setup opts playerOpts =
  insert (SProxy ∷ SProxy "scrubThumbnails") opts' $ playerOpts { plugins = thumbnails : playerOpts.plugins }
  where
    opts' =
      { backdropHeight: toNullable opts.backdropHeight
      , spotlightHeight: toNullable opts.spotlightHeight
      , thumbs: opts.thumbs
      }
