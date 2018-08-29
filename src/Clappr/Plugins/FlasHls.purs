module Clappr.Plugins.FlasHls where

import Prelude

import Clappr (FlashPlugin, NativeOptions, NativeOptionsRow, toPlugin)
import Control.Monad.Eff (Eff, kind Effect)
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe, toNullable)
import Data.Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (class RowLacks)

foreign import data NAVIGATOR ∷ Effect

foreign import flashVersionImpl ∷ ∀ eff. Eff (navigator ∷ NAVIGATOR | eff) (Nullable String)

flashVersion ∷ ∀ eff. Eff (navigator ∷ NAVIGATOR | eff) (Maybe String)
flashVersion = toMaybe <$> flashVersionImpl

setup
  ∷ ∀ r
  . RowLacks "flasHls" (NativeOptionsRow r)
  ⇒ Maybe String
  → FlashPlugin
  → String
  → NativeOptions r
  → NativeOptions (flasHls ∷ Unit | r)
setup flashVersionVal flashPlugin baseUrl opts =
  let
    flasHls = toPlugin flashPlugin
    opts' = case flashVersionVal of
      Just _ →
        opts { plugins = flasHls : opts.plugins, baseUrl = toNullable $ Just baseUrl }
      Nothing →
        opts { baseUrl = toNullable $ Nothing }
  in
    insert (SProxy ∷ SProxy "flasHls") unit opts'
