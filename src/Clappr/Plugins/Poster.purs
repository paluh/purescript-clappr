module Clappr.Plugins.Poster where

import Clappr (NativeOptionsRow, Plugin) as Clappr
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Foreign (Foreign)
import Foreign.Class (encode)
import Foreign.NullOrUndefined (undefined)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (type (+))

foreign import poster ∷ Clappr.Plugin

data Poster
  = Url String
  | Background String

type Options =
  { poster ∷ Poster
  , showOnVideoEnd ∷ Boolean
  , showForNoOp ∷ Boolean
  }

type NativePosterOptions =
  { custom ∷ Foreign
  , showForNoOp ∷ Boolean
  , showOnVideoEnd ∷ Boolean
  , url ∷ Foreign
  }

type NativeOptionsRow r = ( poster ∷ NativePosterOptions | r )

setup
  ∷ ∀ r
  . Lacks "poster" r
  ⇒ Maybe Options
  → { | Clappr.NativeOptionsRow + r }
  → { | Clappr.NativeOptionsRow + NativeOptionsRow + r }
setup (Just { poster: p, showForNoOp, showOnVideoEnd }) opts =
  case p of
    Url url →
      insert
        (SProxy ∷ SProxy "poster")
        { custom: undefined
        , showForNoOp
        , showOnVideoEnd
        , url: encode (Just url)
        }
        opts'
    Background b →
      insert
        (SProxy ∷ SProxy "poster")
        { custom: encode (Just b)
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
