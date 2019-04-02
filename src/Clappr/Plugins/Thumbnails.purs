module Clappr.Plugins.Thumbnails where

import Prelude

import Clappr (NativeOptions, Plugin) as Clappr
import Data.Array ((:))
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))

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
  . Lacks "scrubThumbnails" r
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
