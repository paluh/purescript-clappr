module Clappr.Plugins.ReplayOnBuffering where

import Prelude

import Clappr (NativeOptionsRow, Plugin, NativeOptions)
import Data.Array ((:))
import Data.Record (insert)
import Type.Prelude (class RowLacks, SProxy(..))

foreign import replayOnBuffering ∷ Plugin

newtype Timeout = Timeout Int

setup
  ∷ ∀ r
  . RowLacks "replayBufferingTimeout" (NativeOptionsRow r)
  ⇒ Timeout
  → NativeOptions r
  → NativeOptions (replayBufferingTimeout ∷ Int | r)
setup (Timeout timeout) opts
  = insert (SProxy ∷ SProxy "replayBufferingTimeout") timeout
  <<< _{ plugins = replayOnBuffering : opts.plugins }
  $ opts
