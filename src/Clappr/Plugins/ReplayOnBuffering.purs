module Clappr.Plugins.ReplayOnBuffering where

import Prelude

import Clappr (NativeOptions, Plugin) as Clappr
import Data.Array ((:))
import Prim.Row (class Lacks)
import Record (insert)
import Type.Prelude (SProxy(..))

foreign import replayOnBuffering ∷ Clappr.Plugin

newtype Timeout = Timeout Int

type NativeOptionsRow r = (replayBufferingTimeout ∷ Int | r)

setup
  ∷ ∀ r
  . Lacks "replayBufferingTimeout" r
  ⇒ Timeout
  → Clappr.NativeOptions r
  → Clappr.NativeOptions (NativeOptionsRow r)
setup (Timeout timeout) opts
  = insert (SProxy ∷ SProxy "replayBufferingTimeout") timeout
  <<< _{ plugins = replayOnBuffering : opts.plugins }
  $ opts
