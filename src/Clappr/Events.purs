module Clappr.Events where

import Prelude

import Clappr (Clappr)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, mkEffectFn1, runEffectFn2)
import Record (modify)
import Type.Prelude (SProxy(..))

type NativeBitrate =
  { bandwidth ∷ Nullable Int
  , height ∷ Int
  , width ∷ Int
  }

foreign import onContainerBitrateImpl ∷ EffectFn2 Clappr (EffectFn1 NativeBitrate Unit) Unit

type Bitrate =
  { bandwidth ∷ Maybe Int
  , height ∷ Int
  , width ∷ Int
  }

onContainerBitrate
  ∷ Clappr
  → (Bitrate → Effect Unit)
  → Effect Unit
onContainerBitrate clappr callback =
  runEffectFn2 onContainerBitrateImpl clappr callback'
 where
  fromNativeBitrate = modify (SProxy ∷ SProxy "bandwidth") toMaybe
  callback' = mkEffectFn1 (callback <<< fromNativeBitrate)

-- | XXX: Fix error type
foreign import data ContainerError ∷ Type
foreign import onContainerErrorImpl ∷ EffectFn2 Clappr (EffectFn1 ContainerError Unit) Unit

onContainerError
  ∷ Clappr
  → (ContainerError → Effect Unit)
  → Effect Unit
onContainerError clappr callback =
  runEffectFn2 onContainerErrorImpl clappr (mkEffectFn1 callback)

-- foreign import onContainerPlaybackdvrstatechanged = function(clappr, callback) {

foreign import data ContainerPlaybackState ∷ Type
foreign import onContainerPlaybackstateImpl ∷ EffectFn2 Clappr (EffectFn1 ContainerPlaybackState Unit) Unit

onContainerPlaybackstate
  ∷ Clappr
  → (ContainerPlaybackState → Effect Unit)
  → Effect Unit
onContainerPlaybackstate clappr callback =
  runEffectFn2 onContainerPlaybackstateImpl clappr (mkEffectFn1 callback)


-- foreign import onContainerReady = function(clappr, callback) {
-- foreign import onContainerReady = function(clappr, callback) {
-- foreign import onContainerStatsReport = function(clappr, callback) {
-- foreign import onContainerStatsReport = function(clappr, callback) {


-- | XXX: Fix error type
foreign import data PlaybackError ∷ Type
foreign import onPlaybackErrorImpl ∷ EffectFn2 Clappr (EffectFn1 PlaybackError Unit) Unit

onPlaybackError
  ∷ Clappr
  → (PlaybackError → Effect Unit)
  → Effect Unit
onPlaybackError clappr callback =
  runEffectFn2 onPlaybackErrorImpl clappr (mkEffectFn1 callback)

-- | XXX: Fix error type
foreign import data PlayerError ∷ Type
foreign import onPlayerErrorImpl ∷ EffectFn2 Clappr (EffectFn1 PlayerError Unit) Unit

onPlayerError
  ∷ Clappr
  → (PlayerError → Effect Unit)
  → Effect Unit
onPlayerError clappr callback =
  runEffectFn2 onPlayerErrorImpl clappr (mkEffectFn1 callback)

foreign import onPlayerFullscreenImpl ∷ EffectFn2 Clappr (EffectFn1 Boolean Unit) Unit

onPlayerFullscreen
  ∷ Clappr
  → (Boolean → Effect Unit)
  → Effect Unit
onPlayerFullscreen clappr callback =
  runEffectFn2 onPlayerFullscreenImpl clappr (mkEffectFn1 callback)

foreign import onPlayerPauseImpl ∷ EffectFn2 Clappr (Effect Unit) Unit

onPlayerPause
  ∷ Clappr
  → Effect Unit
  → Effect Unit
onPlayerPause = runEffectFn2 onPlayerPauseImpl

foreign import onPlayerPlayImpl ∷ EffectFn2 Clappr (Effect Unit) Unit

onPlayerPlay
  ∷ Clappr
  → Effect Unit
  → Effect Unit
onPlayerPlay = runEffectFn2 onPlayerPlayImpl

foreign import onPlayerReadyImpl ∷ EffectFn2 Clappr (Effect Unit) Unit

onPlayerReady
  ∷ Clappr
  → Effect Unit
  → Effect Unit
onPlayerReady = runEffectFn2 onPlayerReadyImpl

-- | XXX: Fix size type
foreign import data Size ∷ Type
foreign import onPlayerResizeImpl ∷ EffectFn2 Clappr (EffectFn1 Size Unit) Unit

onPlayerResize
  ∷ Clappr
  → (Size → Effect Unit)
  → Effect Unit
onPlayerResize clappr callback =
  runEffectFn2 onPlayerResizeImpl clappr (mkEffectFn1 callback)

foreign import onPlayerStopImpl ∷ EffectFn2 Clappr (Effect Unit) Unit

onPlayerStop
  ∷  Clappr
  → Effect Unit
  → Effect Unit
onPlayerStop = runEffectFn2 onPlayerStopImpl

type Progress =
  { current ∷ Number
  , total ∷ Number
  }

foreign import onPlayerTimeupdateImpl ∷ EffectFn2 Clappr (EffectFn1 Progress Unit) Unit

onPlayerTimeupdate
  ∷ Clappr
  → (Progress → Effect Unit)
  → Effect Unit
onPlayerTimeupdate clappr callback =
  runEffectFn2 onPlayerTimeupdateImpl clappr (mkEffectFn1 callback)

foreign import onPlayerVolumeupdateImpl ∷ EffectFn2 Clappr (EffectFn1 Number Unit) Unit

onPlayerVolumeupdate
  ∷ Clappr
  → (Number → Effect Unit)
  → Effect Unit
onPlayerVolumeupdate clappr callback =
  runEffectFn2 onPlayerVolumeupdateImpl clappr (mkEffectFn1 callback)

-- http://clappr.github.io/classes/Events.html
-- onContainerDestroyed
-- onContainerLoadedmetadata
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
