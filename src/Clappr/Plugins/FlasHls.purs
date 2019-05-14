module Clappr.Plugins.FlasHls where

import Prelude

import Clappr (FlashPlugin, flasHls, hls, toPlugin)
import Clappr (NativeOptions) as Clappr
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe, toNullable)
import Effect (Effect)
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))
import Type.Row (type (+))

foreign import flashVersionImpl ∷ Effect (Nullable String)

flashVersion ∷ Effect (Maybe FlashVersion)
flashVersion = (map FlashVersion <<< toMaybe) <$> flashVersionImpl

newtype FlashVersion = FlashVersion String

foreign import canUseFlash ∷ Effect Boolean

-- Even if flash is available there are some FF versions
-- which won't work with it.
type Config =
  { plugin ∷ FlashPlugin
  , version ∷ FlashVersion
  }

type NativeOptionsRow r = (flasHls ∷ Boolean | r)

setup
  ∷ ∀ r
  . Lacks "flasHls" r
  ⇒ Config
  → String
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow + r)
setup config baseUrl opts =
  let
    flasHls = toPlugin config.plugin
    opts' = opts { plugins = flasHls : hls: opts.plugins, baseUrl = toNullable $ Just baseUrl }
  in
    insert (SProxy ∷ SProxy "flasHls") true opts'

trySetup
  ∷ ∀ r
  . Lacks "flasHls" r
  ⇒ String
  → Effect (Clappr.NativeOptions r → Clappr.NativeOptions (NativeOptionsRow + r))
trySetup baseUrl = do
  maybeVersion ← flashVersion
  useFlash ← canUseFlash
  plugin ← flasHls
  pure $ case useFlash, maybeVersion of
    true, Just version →
      setup { plugin, version } baseUrl
    _, _ →
      insert (SProxy ∷ SProxy "flasHls") false

