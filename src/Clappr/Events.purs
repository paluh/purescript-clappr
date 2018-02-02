module Clappr.Events where

import Prelude

import Clappr (CLAPPR, Clappr)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Uncurried (EffFn1, EffFn2, mkEffFn1, runEffFn2)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Data.Record (modify)
import Type.Prelude (SProxy(..))

type ClapprEff eff = (exception ∷ EXCEPTION, clappr ∷ CLAPPR | eff)

type NativeBitrate =
  { bandwidth ∷ Nullable Int
  , height ∷ Int
  , width ∷ Int
  }

foreign import onContainerBitrateImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) NativeBitrate Unit) Unit

type Bitrate =
  { bandwidth ∷ Maybe Int
  , height ∷ Int
  , width ∷ Int
  }

onContainerBitrate
  ∷ forall eff
  . Clappr
  → (Bitrate → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onContainerBitrate clappr callback =
  runEffFn2 onContainerBitrateImpl clappr callback'
 where
  fromNativeBitrate = modify (SProxy ∷ SProxy "bandwidth") toMaybe
  callback' = mkEffFn1 (callback <<< fromNativeBitrate)

-- | XXX: Fix error type
foreign import data ContainerError ∷ Type
foreign import onContainerErrorImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) ContainerError Unit) Unit

onContainerError
  ∷ forall eff
  . Clappr
  → (ContainerError → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onContainerError clappr callback =
  runEffFn2 onContainerErrorImpl clappr (mkEffFn1 callback)

-- | XXX: Fix error type
foreign import data PlaybackError ∷ Type
foreign import onPlaybackErrorImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) PlaybackError Unit) Unit

onPlaybackError
  ∷ forall eff
  . Clappr
  → (PlaybackError → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onPlaybackError clappr callback =
  runEffFn2 onPlaybackErrorImpl clappr (mkEffFn1 callback)

-- | XXX: Fix error type
foreign import data PlayerError ∷ Type
foreign import onPlayerErrorImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) PlayerError Unit) Unit

onPlayerError
  ∷ forall eff
  . Clappr
  → (PlayerError → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onPlayerError clappr callback =
  runEffFn2 onPlayerErrorImpl clappr (mkEffFn1 callback)

foreign import onPlayerFullscreenImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) Boolean Unit) Unit

onPlayerFullscreen
  ∷ forall eff
  . Clappr
  → (Boolean → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onPlayerFullscreen clappr callback =
  runEffFn2 onPlayerFullscreenImpl clappr (mkEffFn1 callback)

foreign import onPlayerPauseImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (Eff (ClapprEff eff) Unit) Unit

onPlayerPause
  ∷ forall eff
  .  Clappr
  → Eff (ClapprEff eff) Unit
  → Eff (ClapprEff eff) Unit
onPlayerPause = runEffFn2 onPlayerPauseImpl

foreign import onPlayerPlayImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (Eff (ClapprEff eff) Unit) Unit

onPlayerPlay
  ∷ forall eff
  .  Clappr
  → Eff (ClapprEff eff) Unit
  → Eff (ClapprEff eff) Unit
onPlayerPlay = runEffFn2 onPlayerPlayImpl

foreign import onPlayerReadyImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (Eff (ClapprEff eff) Unit) Unit

onPlayerReady
  ∷ forall eff
  .  Clappr
  → Eff (ClapprEff eff) Unit
  → Eff (ClapprEff eff) Unit
onPlayerReady = runEffFn2 onPlayerReadyImpl

-- | XXX: Fix size type
foreign import data Size ∷ Type
foreign import onPlayerResizeImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) Size Unit) Unit

onPlayerResize
  ∷ forall eff
  . Clappr
  → (Size → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onPlayerResize clappr callback =
  runEffFn2 onPlayerResizeImpl clappr (mkEffFn1 callback)

foreign import onPlayerStopImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (Eff (ClapprEff eff) Unit) Unit

onPlayerStop
  ∷ forall eff
  .  Clappr
  → Eff (ClapprEff eff) Unit
  → Eff (ClapprEff eff) Unit
onPlayerStop = runEffFn2 onPlayerStopImpl

type Progress =
  { current ∷ Number
  , total ∷ Number
  }

foreign import onPlayerTimeupdateImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) Progress Unit) Unit

onPlayerTimeupdate
  ∷ forall eff
  . Clappr
  → (Progress → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onPlayerTimeupdate clappr callback =
  runEffFn2 onPlayerTimeupdateImpl clappr (mkEffFn1 callback)

foreign import onPlayerVolumeupdateImpl ∷ ∀ eff. EffFn2 (ClapprEff eff) Clappr (EffFn1 (ClapprEff eff) Number Unit) Unit

onPlayerVolumeupdate
  ∷ forall eff
  . Clappr
  → (Number → Eff (ClapprEff eff) Unit)
  → Eff (ClapprEff eff) Unit
onPlayerVolumeupdate clappr callback =
  runEffFn2 onPlayerVolumeupdateImpl clappr (mkEffFn1 callback)

-- http://clappr.github.io/classes/Events.html
-- onContainerDestroyed
-- onContainerLoadedmetadata
-- onContainerPlaybackdvrstatechanged
-- onContainerPlaybackstate
-- onContainerReady
-- onContainerStatsReport
-- onContainerSubtitleAvailable
-- onContainerSubtitleChanged
-- onContainerTimeupdate
-- onCoreContainersCreated
-- onCoreFullscreen
-- onCoreOptionsChange
-- onCoreReady
-- onCoreScreenOrientationChanged
-- onPlaybackBitrate
-- onPlaybackBufferfull
-- onPlaybackBuffering
-- onPlaybackDvr
-- onPlaybackEnded
-- onPlaybackFragmentLoaded
-- onPlaybackHighdefinitionupdate
-- onPlaybackLevelSwitch
-- onPlaybackLevelSwitchEnd
-- onPlaybackLevelSwitchStart
-- onPlaybackLevelsAvailable
-- onPlaybackLoadedmetadata
-- onPlaybackMediacontrolDisable
-- onPlaybackMediacontrolEnable
-- onPlaybackPause
-- onPlaybackPlay
-- onPlaybackPlayIntent
-- onPlaybackPlaybackstate
-- onPlaybackProgress
-- onPlaybackReady
-- onPlaybackSeeked
-- onPlaybackSettingsupdate
-- onPlaybackStatsAdd
-- onPlaybackStop
-- onPlaybackSubtitleAvailable
-- onPlaybackSubtitleChanged
-- onPlaybackTimeupdate
-- onPlayerEnded
-- onPlayerSeek
-- onPlayerSubtitleAvailable
