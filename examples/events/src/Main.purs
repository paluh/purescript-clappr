module Examples.Events.Main where

import Prelude

import Clappr (Parent(..), clappr, toNativeOptions)
import Clappr.Events (onContainerBitrate, onContainerError, onPlaybackError, onPlayerError, onPlayerFullscreen, onPlayerPause, onPlayerPlay, onPlayerReady, onPlayerResize, onPlayerTimeupdate, onPlayerVolumeupdate)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (new, read, write) as Ref
import Global.Unsafe (unsafeStringify)

main
  ∷ { parentId ∷ String, source ∷ String }
  → Effect Unit
main cfg = do
  let
    opts =
      toNativeOptions
        { autoPlay: false
        , baseUrl: Nothing
        , hlsjsConfig: Nothing
        , hlsRecoverAttempts: Nothing
        , mute: false
        , parent: ParentId cfg.parentId
        , source: cfg.source
        }
  c ← clappr opts
  onContainerBitrate c (\b → do
    log "CONTAINER_BITRATE"
    log $ unsafeStringify b)
  onContainerError c (\e → do
    log "CONTAINER_ERROR"
    log $ unsafeStringify e)
  onPlaybackError c (\e → do
    log "PLAYBACK_ERROR"
    log $ unsafeStringify e)
  onPlayerError c (\e → do
    log "PLAYER_ERROR"
    log "Have you changed fake hls url in index.html?"
    log $ unsafeStringify e)
  onPlayerFullscreen c (\b → do
    log "PLAYER_FULLSCREEN"
    log $ unsafeStringify b)
  onPlayerPause c (log "PLAYER_PAUSE")
  onPlayerPlay c (log "PLAYER_PLAY")
  onPlayerReady c (log "PLAYER_READY")
  onPlayerResize c (\s → do
    log "PLAYER_RESIZE"
    log $ unsafeStringify s)
  -- throttling timeupdate a bit
  ir ← Ref.new 0
  onPlayerTimeupdate c (\p → do
    i ← Ref.read ir
    when (i `mod` 50 == 0) do
      log "PLAYER_TIMEUPDATE (throttled)"
      log $ unsafeStringify p
    Ref.write (i + 1) ir)
  onPlayerVolumeupdate c (\v → do
    log "PLAYER_VOLUMEUPDATE"
    log $ unsafeStringify v)
  log "Hello sailor!"
