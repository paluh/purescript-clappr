module Clappr.Plugins.MediaControl where

import Prelude

import Clappr (NativeOptions) as Clappr
import Clappr (Plugin)
import Data.Array ((:))
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (type (+))

type Config =
  { duration ∷ Boolean
  , fullScreen ∷ Boolean
  , hdIndicator ∷ Boolean
  , playStop ∷ Boolean
  , position ∷ Boolean
  , seekBar ∷ Boolean
  , volume ∷ Boolean
  }

foreign import mediaControlSetup ∷ Nullable Config → Plugin

type NativeOptionsRow r = (mediaControl ∷ Unit | r)

setup
  ∷ ∀ r
  . Lacks "mediaControl" r
  ⇒ Maybe Config
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow + r)
setup cfg opts =
  insert (SProxy ∷ SProxy "mediaControl") unit opts'
  where
    opts' = opts { plugins = mediaControlSetup (toNullable cfg) : opts.plugins }


