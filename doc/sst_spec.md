# Super Star Trek Specification

```
                ,------*------,
,-------------   '---  ------'
 '-------- --'      / /
     ,---' '-------/ /--,
      '----------------'
THE USS ENTERPRISE --- NCC-1701
```

## Overview

The goal of the game is to destroy all the Klingon cruisers in the
galaxy within a certain timeframe.

### Galactic Layout

The galaxy is a 8x8 grid of quadrants. Each quadrant is further
subdivided into an 8x8 grid of sectors.

All battle action takes place in a single quadrant isolated from the
ships in the other quadrants.

Each sector contains one thing, which might be:

* The Enterprise
* A Klingon
* A starbase
* A star

### Map of the Galaxy

Each quadrant has a name and an optional Roman numeral after.

For example row 5, column 6 is `ALDEBARAN II`.

```
    1   2   3   4   5   6   7   8

1        ANTARES        SIRIUS
    I   II  III IV  I   II  III IV

2         RIGEL         DENEB
    I   II  III IV  I   II  III IV

3        PROCYON       CAPELLA
    I   II  III IV  I   II  III IV

4         VEGA        BETELGEUSE
    I   II  III IV  I   II  III IV

5        CANOPUS       ALDEBARAN
    I   II  III IV  I   II  III IV

6        ALTAIR         REGULUS
    I   II  III IV  I   II  III IV

7      SAGITTARIUS     ARCTURUS
    I   II  III IV  I   II  III IV

8        POLLUX         SPICA
    I   II  III IV  I   II  III IV
```

## Setup

As the game begins, the following initialization takes place:

* Print the welcome splash:

  ```
                                      ,------*------,
                      ,-------------   '---  ------'
                       '-------- --'      / /
                           ,---' '-------/ /--,
                            '----------------'
  
                      THE USS ENTERPRISE --- NCC-1701
  ```

* Choose the starting stardate.

  This is computed as a random integer in the range `[20,39]` multiplied
  by `100`.

* Set the current stardate (a floating point value) to the starting
  stardate.

* Compute the length of the mission in stardates (analogous to "days").

  Choose a random integer `[1,9]`, and add `25` to it.

* Set the maximum possible Enterprise energy level to `3000`.

* Set the current Enterprise energy level to the maximum possible energy
  level.

* Set the maximum possible Enterprise photon torpedo count to `10`.

* Set the current Enterprise photon torpedo count to the maximum
  possible count.
 
* Set the current Enterprise shield level to `0`.

* Set the Enterprise's quadrant to a random row and column, each in the
  range `[1,8]`.

  > Note: the BASIC game is one-based for indexes, but zero-based would
  > work equally well. This spec sticks with one-based for historical
  > accuracy.

* Set the Enterprise's sector to a random row and column, each in the
  range `[1,8]`.
 
* Set the damage level of each of Enterprise's eight systems to `0`.

  These systems are described in more detail later, but they are:

  1. Warp engines
  2. Short Range Sensors
  3. Long Range Sensors
  4. Phaser Control
  5. Photon Tubes
  6. Damage Control
  7. Shield Control
  8. Library-Computer

* Initialize all quadrants in the galaxy.

  1. Mark the quadrant as "undiscovered".

  2. Each quadrant is assigned three numbers representing its contents.

     > In the BASIC game, these numbers were stored as a three digit
     > number `xyz` where `x` is the number of Klingons, `y` is the
     > number of starbases, and `z` is the number of stars.

     * The Klingon count in the quadrant is based on these probabilities:

       |Chance|Count|
       |-----:|----:|
       |   2% |   3 |
       |   3% |   2 |
       |  15% |   1 |
       |  80% |   0 |

     * The starbase count is based on these probabilities:

       |Chance|Count|
       |-----:|----:|
       |   4% |   1 |
       |  96% |   0 |
  
     * Number of stars is a random number in the range `[1,8]`.

     As the map is built, track both the total number of Klingons and
     the total number of starbases in the galaxy.

* Fix the stardate in case there are too many Klingons--it could be that
  the game is too short to destroy all the Klingons.

  If the number of Klingons in the galaxy is greater than the length of
  the mission (in stardates), set the mission length to the number of
  Klingons plus `1`.

* Fix the number of starbases--it could be that randomly there are zero
  starbases, and we don't want to allow that.

  If the total number of starbases in the galaxy is `0`, do the
  following:

  1. If there are fewer than `2` Klingons in the Enterprise's quadrant,
     increment the number of Klingons in the quadrant by 1.

     Increment the total number of Klingons in the galaxy.

  2. Increment the number of starbases in the Enterprise's quadrant
     (from `0` to `1`).

     Set the total number of starbases in the galaxy to `1`.

  3. Move the Enterprise to a random quadrant row and column in the
     range `[1,8]`. (Leave its current sector coordinates intact.)

* Record the original number of Klingons in the galaxy. (This will be
  used at the end of the game for scoring purposes.)

* Print the introduction message.

  ```
  YOUR ORDERS ARE AS FOLLOWS:
       DESTROY THE xx KLINGON WARSHIPS WHICH HAVE INVADED
     THE GALAXY BEFORE THEY CAN ATTACK FEDERATION HEADQUARTERS
     ON STARDATE yyyy  THIS GIVES YOU zz DAYS.  THERE ARE
     ww STARBASES IN THE GALAXY FOR RESUPPLYING YOUR SHIP

  HIT ANY KEY EXCEPT RETURN WHEN READY TO ACCEPT COMMAND
  ```

  > The BASIC code fixes the above message for plurality surrounding the
  > starbases, but assumes the other numbers will be non-`1`.

* Call the [Entering a New Quadrant](#entering-a-new-quadrant) code.

## Order of Play

TODO

## Entering a New Quadrant

* Mark the quadrant as "discovered".

* Print an "entering quadrant" message with the full quadrant name and
  Roman numeral:

  On first entry, this prints:

  ```
  YOUR MISSION BEGINS WITH YOUR STARSHIP LOCATED
  IN THE GALACTIC QUADRANT, 'qqqqqqqq'.
  ```

  On subsequent entries, it prints:

  ```
  NOW ENTERING qqqqqqqq QUADRANT . . .
  ```

* If there are Klingons in the quadrant, print a combat warning message.

  ```
  COMBAT AREA      CONDITION RED
  ```

  * If Enterprise shield level is less than or equal to `200`, print a
    warning message about shields being low.

    ```
       SHIELDS DANGEROUSLY LOW
    ```

TODO
