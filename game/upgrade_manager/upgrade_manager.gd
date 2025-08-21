class_name UpgradeManager
extends Node2D

## The current base payout amount for each mushroom type
var base_payout_amounts: Array[float] = [1, 1, 1]

## The range where a given type of mushroom will look for neighbors
var neighbor_ranges: Array[int] = [1, 1, 1]
## Additive bonus per neighboring same type mushroom
var neighbor_add_bonuses: Array[float] = [1, 1, 1]
## Multiplicative bonus per neighboring same type mushroom
var neighbor_mult_bonuses: Array[float] = [1, 1, 1]
