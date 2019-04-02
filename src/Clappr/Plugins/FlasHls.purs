module Clappr.Plugins.FlasHls where

import Prelude

import Clappr (FlashPlugin, hls, NativeOptions, toPlugin)
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe, toNullable)
import Effect (Effect)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))

foreign import flashVersionImpl ∷ Effect (Nullable String)

flashVersion ∷ Effect (Maybe String)
flashVersion = toMaybe <$> flashVersionImpl

setup
  ∷ ∀ r
  . Lacks "flasHls" r
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
        opts { plugins = flasHls : hls: opts.plugins, baseUrl = toNullable $ Just baseUrl }
      Nothing →
        opts { baseUrl = toNullable $ Nothing }
  in
    insert (SProxy ∷ SProxy "flasHls") unit opts'
