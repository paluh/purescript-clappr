module Clappr.Plugins.Poster where

import Clappr (NativeOptions, Plugin, NativeOptionsRow)
import Data.Array ((:))
import Data.Foreign (Foreign)
import Data.Foreign.Class (encode)
import Data.Foreign.NullOrUndefined (NullOrUndefined(..), undefined)
import Data.Maybe (Maybe(..))
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import poster ∷ Plugin

data Poster
  = Url String
  | Background String

type Options =
  { poster ∷ Poster
  , showOnVideoEnd ∷ Boolean
  , showForNoOp ∷ Boolean
  }

setup
  ∷ ∀ r
  . RowLacks "poster" (NativeOptionsRow r)
  ⇒ Maybe Options
  → NativeOptions r
  → NativeOptions
    ( poster ∷
      { custom ∷ Foreign
      , showForNoOp ∷ Boolean
      , showOnVideoEnd ∷ Boolean
      , url ∷ Foreign }
    | r
    )
setup (Just { poster: p, showForNoOp, showOnVideoEnd }) opts =
  case p of
    Url url →
      insert
        (SProxy ∷ SProxy "poster")
        { custom: undefined
        , showForNoOp
        , showOnVideoEnd
        , url: encode (NullOrUndefined (Just url))
        }
        opts'
    Background b →
      insert
        (SProxy ∷ SProxy "poster")
        { custom: encode (NullOrUndefined (Just b))
        , showForNoOp
        , showOnVideoEnd
        , url: undefined
        }
        opts'
 where
  opts' = opts { plugins = poster : opts.plugins }
setup Nothing opts =
  insert
    (SProxy ∷ SProxy "poster")
    { custom: undefined
    , showForNoOp: false
    , showOnVideoEnd: false
    , url: undefined
    }
    opts'
 where
  opts' = opts { plugins = poster : opts.plugins }
