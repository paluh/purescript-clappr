module DvrControls where

import Clappr (Plugin, NativeOptions)
import Data.Array ((:))

foreign import dvrControls ∷ Plugin

setup ∷ ∀ r. NativeOptions r → NativeOptions r
setup opts = opts { plugins = dvrControls : opts.plugins }
