module Main where

import Prelude

import Clappr (CLAPPR, Parent(..), clappr)
import Clappr.Events (onContainerBitrate, onContainerError, onPlaybackError, onPlayerError, onPlayerFullscreen, onPlayerPause, onPlayerPlay, onPlayerReady, onPlayerResize, onPlayerTimeupdate, onPlayerVolumeupdate)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Ref (REF, newRef, readRef, writeRef)
import DOM (DOM)
import Debug.Trace (traceAnyA)

main :: String → String → forall e. Eff (clappr ∷ CLAPPR, console :: CONSOLE, dom ∷ DOM, exception ∷ EXCEPTION, ref ∷ REF | e) Unit
main parentId source = do
  c ← clappr
    { clickToPause: true
    , parent: ParentId parentId
    , source: source
    }
  onContainerBitrate c (\b → do
    log "CONTAINER_BITRATE"
    traceAnyA b)
  onContainerError c (\e → do
    log "CONTAINER_ERROR"
    traceAnyA e)
  onPlaybackError c (\e → do
    log "PLAYBACK_ERROR"
    traceAnyA e)
  onPlayerError c (\e → do
    log "PLAYER_ERROR"
    log "Have you changed fake hls url in index.html?"
    traceAnyA e)
  onPlayerFullscreen c (\b → do
    log "PLAYER_FULLSCREEN"
    traceAnyA b)
  onPlayerPause c (log "PLAYER_PAUSE")
  onPlayerPlay c (log "PLAYER_PLAY")
  onPlayerReady c (log "PLAYER_READY")
  onPlayerResize c (\s → do
    log "PLAYER_RESIZE"
    traceAnyA s)
  -- throttling timeupdate a bit
  ir ← newRef 0
  onPlayerTimeupdate c (\p → do
    i ← readRef ir
    when (i `mod` 50 == 0) do
      log "PLAYER_TIMEUPDATE (throttled)"
      traceAnyA p
    writeRef ir (i + 1))
  onPlayerVolumeupdate c (\v → do
    log "PLAYER_VOLUMEUPDATE"
    traceAnyA v)
  log "Hello sailor!"
