<!--
TODO

Move SRS note down
Add appendices
* Damage systems
* Map of the galaxy
  * Fix map to proper game output
-->

# Super Star Trek Specification

```
                ,------*------,
,-------------   '---  ------'
 '-------- --'      / /
     ,---' '-------/ /--,
      '----------------'
THE USS ENTERPRISE --- NCC-1701
```

**WORK IN PROGRESS**

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

## Order of Play

* Initialization and setup:
  * [Initialize game](#initialize-game).
  * [Enter a New Quadrant](#entering-a-new-quadrant).
  * Perform a [Short Range Sensor Scan](#short-range-sensor-scan).
* Start of Main Loop with SRS:
  * Perform a [Short Range Sensor Scan](#short-range-sensor-scan).
* Start of Main Loop:
  * [Check for Out of Energy](#check-for-out-of-energy).
  * [Execute User Command](#execute-user-command).

TODO

## Initialize Game

As the game begins, the following initialization takes place:

* Print 11 blank lines.

* Print the welcome splash:

  ```
                                      ,------*------,
                      ,-------------   '---  ------'
                       '-------- --'      / /
                           ,---' '-------/ /--,
                            '----------------'
  
                      THE USS ENTERPRISE --- NCC-1701
  ```

* Print 5 blank lines.

* Choose the starting stardate.

  This is computed as a random integer in the range `[20,39]` multiplied
  by `100`.

* Set the current stardate (a floating point value) to the starting
  stardate.

* Compute the length of the mission in stardates (analogous to "days").

  Choose a random integer in the range `[25,34]`.

* Set the maximum possible Enterprise main energy level to `3000`.

* Set the current Enterprise main energy level to the maximum possible
  main energy level.

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

  All values are assumed to be non-`1`, with the exception of the total
  starbase count.

  If the total starbase count is `1`, the output is correctly
  singularized to

  ```
                                          [...] THERE IS
     1 STARBASE IN THE GALAXY [...]
  ```

  > It is unclear why `RETURN` is not an acceptable key to hit, but the
  > code actively ignores it.

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

* Clear the 8x8 grid representing the sectors in the Enterprise's
  current quadrant.

* Place the Enterprise in its current sector.

* Look up the number of Klingons in this quadrant. Place that many in
  random, empty sectors.
 
* Assign each Klingon in the quadrant a random energy level in the range
  `[100,300)`.

* If there is a starbase in this quadrant, place it at a random, unused
  sector.

* Look up the number of stars in this quadrant. Place that many stars in
  random unused sectors.

## Short Range Sensor Scan

* Determine if the Enterprise is docked.

  The Enterprise is docked if it is adjacent to a starbase, including
  diagonals.

* If the Enterprise is docked:

  * Set current Enterprise main energy level to maximum.
  * Set photon torpedo count to maximum.
  * Set shields to `0`.
  * Print a shields message:
    ```
    SHIELDS DROPPED FOR DOCKING PURPOSES
    ```

> Arguably, the above doesn't belong in the Short Range Sensor code, but
> it's in there in the original source.

* Determine the ship's battle condition:

  * If there are any Klingon's in the quadrant, the condition is
    `*RED*`.

  * Else if the Enterprise's main energy (not counting shields) is less
    than 10% of maximum, the condition is `YELLOW`.

  * Else the condition is `GREEN`.


* If the Short Range Sensors are damaged, print a message and return
  from the Short Range Sensors routine.

  ```
  *** SHORT RANGE SENSORS ARE OUT ***
  ```

* Otherwise, print out the Short Range Sensor Scan. The layout of the
  screen is as follows, with filler `...` and `xxx` in the sector
  positions, and filler values on the right:

  ```
  ---------------------------------
   ... xxx ... xxx ... xxx ... xxx        STARDATE           ssss[.s]
   xxx ... xxx ... xxx ... xxx ...        CONDITION          cccc
   ... xxx ... xxx ... xxx ... xxx        QUADRANT           q , q
   xxx ... xxx ... xxx ... xxx ...        SECTOR             s , s
   ... xxx ... xxx ... xxx ... xxx        PHOTON TORPEDOES   tt
   xxx ... xxx ... xxx ... xxx ...        TOTAL ENERGY       eeee
   ... xxx ... xxx ... xxx ... xxx        SHIELDS            ssss
   xxx ... xxx ... xxx ... xxx ...        KLINGONS REMAINING kk
  ---------------------------------
  ```

  The actual sector contents will be 3 spaces each, and are as follows:

  |Value|Description|
  |:---:|-----------|
  |`<*>`|Enterprise |
  |`+K+`|Klingon    |
  |`>!<`|Starbase   |  <!-- In order to get this rendered right,     -->
  |` * `|Star       |  <!-- these are nonbreaking spaces in the star -->
  |`   `|Empty space|  <!-- and empty space entries. UTF-8 0xA0.     -->

  The `STARDATE` is printed as an integer if it is a whole number.
  Otherwise it is printed with 1 digit past the decimal place.

  All other numeric values are printed as truncated integers.

  `TOTAL ENERGY` is the Enterprise's main energy plus its shield energy.
  `SHIELDS` is just the shield energy.

  `KLINGONS REMAINING` is total Klingons in the game.

  Example:

  ```
  ---------------------------------
                                          STARDATE           3061.2
        *          <*>                    CONDITION          *RED*
                                          QUADRANT           7 , 1 
                                          SECTOR             2 , 5
                        *                 PHOTON TORPEDOES   3
           >!<                            TOTAL ENERGY       1929
                           +K+            SHIELDS            430
                                          KLINGONS REMAINING 6
  ---------------------------------
  ```

## Check for Out Of Energy

Note that the total energy in the Enterprise is the main energy level
plus the shield energy level. (Energy can be moved from main energy to
shields and back).

If the Enterprise's total energy (shields + main) is `10` or lower,
the Enterprise is out of power.

If the total energy is greater than `10`, but the main energy alone is
`10` or lower AND shield control is damaged, the Enterprise is out of
power.

If the Enterprise is out of power, print a message (below), then jump to
[Game Over (intact)](#game-over). Note that a blank line is printed
before this output.

```

** FATAL ERROR **   YOU'VE JUST STRANDED YOUR SHIP IN 
SPACE
YOU HAVE INSUFFICIENT MANEUVERING ENERGY, AND SHIELD CONTROL
IS PRESENTLY INCAPABLE OF CROSS-CIRCUITING TO ENGINE ROOM!!
```

> Note: in the output above, it feels like the intent might have been to
> have the word `SPACE` on the first line. This speculation is further
> bolstered by the presence of an explicit space after the word `IN`,
> and the fact that subsequent code suppresses newlines liberally as it
> packs the source in 80-column lines. To fix this, a semicolon would
> have to be added at the end of the first line. But no such thing is
> present in the source.

## Execute User Command

A command prompt is printed (with a trailing space):

```
COMMAND? 
```

The case-sensitive commands are as follows:

|Command|Description               |
|-------|--------------------------|
|`NAV`  |[Navigate](#navigation)   |
|`SRS`  |Short range sensor scan   | <!-- TODO -->
|`LRS`  |Long range sensor scan    |
|`PHA`  |Fire phasers              |
|`TOR`  |Fire torpedos             |
|`SHE`  |Change shield levels      |
|`DAM`  |Damage control report     |
|`COM`  |Library computer functions|
|`XXX`  |Resign                    |

If an unrecognized command is entered, a usage message is printed (with
a trailing blank line), and control is returned to the [start of the Main
Loop](#order-of-play).

```
ENTER ONE OF THE FOLLOWING:
  NAV  (TO SET COURSE)
  SRS  (FOR SHORT RANGE SENSOR SCAN)
  LRS  (FOR LONG RANGE SENSOR SCAN)
  PHA  (TO FIRE PHASERS)
  TOR  (TO FIRE PHOTON TORPEDOES)
  SHE  (TO RAISE OR LOWER SHIELDS)
  DAM  (FOR DAMAGE CONTROL REPORTS)
  COM  (TO CALL ON LIBRARY-COMPUTER)
  XXX  (TO RESIGN YOUR COMMAND)

```

## Navigation

A lot of things happen when you navigate:

1. The Enterprise movement user input is gathered.
2. The Klingons move.
3. Damaged subsystems are repaired.
4. Random damage event occurs.
5. Enterprise moves.
6. TODO

To navigate, the user selects a course from 0-9 (fractional courses are
supported). The course direction layout is:
               
```
  4  3  2
   \ | /
    \|/
5 ---*--- 1 or 9
    /|\
   / | \
  6  7  8
```

Course 9 is the same as course 1. Further wrapping of directions is
unsupported (i.e. course `10` is not the same as `2`, and, in fact, does
not exist). There are no negative course directions.

If the Warp Engines are damaged, the maximum warp number is `0.2`.

Gameplay:

* Present the user with a course direction prompt (with trailing space):

  ```
  COURSE (0-9)? 
  ```

  `0` is an option here to allow the user to cancel the navigation
  action. Sulu will still complain about it, below.

* If the entered course is less than `1` or greater than `9`, print an
  error message, then return to the [start of the Main
  Loop](#order-of-play).

  The error message has 3 leading spaces:

  ```
     LT. SULU REPORTS, 'INCORRECT COURSE DATA, SIR!'
  ```

* Present the user with a warp speed prompt (with trailing space).

  If the Warp Engines aren't damaged:

  ```
  WARP FACTOR(0-8)? 
  ```

  If the Warp Engines are damaged:

  ```
  WARP FACTOR(0-0.2)? 
  ```

* If the entered warp value is `0`, silently return to the [start of the
  Main Loop](#order-of-play).

* If the Warp Engines are damaged and the user enters more than `0.2`,
  print an error message and return to the [start of the Main
  Loop](#order-of-play).

  ```
  WARP ENGINES ARE DAMAGED.  MAXIUM SPEED = WARP 0.2
  ```

  > `MAXIUM` is a typo in the BASIC source.

* If user enters more than `8` or less than `1`, print an error message
  and return to the [start of the Main Loop](#order-of-play).

  There are 3 leading spaces on this message:

  ```
     CHIEF ENGINEER SCOTT REPORTS 'THE ENGINES WON'T TAKE WARP  www!'
  ```

  > There will be two spaces before a positive warp number in the error
  > message since MBASIC prints a space before positive numbers, and the
  > code contains an additional explicit space. But if the user enters a
  > negative warp number, there would only be one space before the minus
  > sign in the warp number.

* Compute the energy required for this maneuver. This is the warp factor
  times `8`, rounded to the nearest integer.

  ```
  energy_needed = int(warp_factor * 8 + .5)
  energy_needed = round_nearest(warp_factor * 8)  // same thing
  ```

* If `energy_needed` is greater than Enterprise main energy, print an
  error message:

  ```
  ENGINEERING REPORTS   'INSUFFICIENT ENERGY AVAILABLE
                         FOR MANEUVERING AT WARP w!'
  ```

  Also perform the following:
  
  * If total energy (main + shields) is greater than or equal to
    `energy_needed` AND shield control is undamaged, let the player
    know. (They might want to transfer some to main to maneuver.)

    ```
    DEFLECTOR CONTROL ROOM ACKNOWLEGES ssss UNITS OF ENERGY
                             PRESENTLY DEPLOYED TO SHIELDS.
    ```

    > "ACKNOWLEGES" is a typo in the original source.

  * Return to the [start of the Main Loop](#order-of-play).

* All Klingons in the quadrant move.

  For each Klingon, move them to an unused random sector in their
  current quadrant.

* Repair damaged systems and report on completed repairs.

  There are 8 systems that can be damaged.

  System damage values are roughly the negative of "stardates needed to
  repair". e.g., `-2.6` would be "2.6 stardates to repair".

  Negative values mean the system is damaged. `0` means it is repaired.

  The number of days it takes to travel is the warp factor, capped at
  `1`.

  So:

  ```
  repair_amount = max(warp_factor, 1)
  ```

  * For each _damaged_ system, add `repair_amount` to their repair
    values, driving those values up toward `0`.

    * If the system damage is greater than `-0.1` and less than `0`, set
      it to `-0.1`.

      > I'm unsure why this happens. Either it's some kind of round-off
      > protection, or some attempt to keep it at one decimal place...?

      Continue to the next system.

    * If the system damage is less than `0`, continue to the next
      system.

    * Report the system repaired.

      * If this is the first system repaired this move, print a header:

        (Two trailing spaces. No newline.)

        ```
        DAMAGE CONTROL REPORT:  
        ```

      * Cursor to the next 8-space tab stop.

        For the first system, this will be directly after the two spaces
        in the header, above.

        For subsequent systems, this will be 8 spaces from the left.

        > Probably. According to the documetation for MBASIC-80, the
        > first tab would actually go to the next line since the cursor
        > was already past the 8th position. But in the sample run in
        > _101 BASIC Computer Games_, it shows it on the same line.

      * Print the system name followed by a repair message:

        ```
        sssssssssss REPAIR COMPLETED.
        ```

        The system names are:

        |ID|Name                |
        |-|---------------------|
        |1|`WARP ENGINES`       |
        |2|`SHORT RANGE SENSORS`|
        |3|`LONG RANGE SENSORS` |
        |4|`PHASER CONTROL`     |
        |5|`PHOTON TUBES`       |
        |6|`DAMAGE CONTROL`     |
        |7|`SHIELD CONTROL`     |
        |8|`LIBRARY-COMPUTER`   |

* Spontaneously damage or speedily repair systems in a random event.

  * There's a 20% chance a random damage even occurs.

    If it does:

    * There's a 60% chance it's a bad random event:

      Damage a random system by a random floating point amount in the
      range `[1,5]`.

      Print a message (followed by a blank line):

      ```
      DAMAGE CONTROL REPORT:  sssssssssssss DAMAGED"

      ```

      System names are noted, above.

    * Else (40% chance) it's a good random event:

      Repair a random system by a random floating point amount in the
      range `[1,3]`.

      Print a message (followed by a blank line):

      ```
      DAMAGE CONTROL REPORT:  sssssssssssss STATE OF REPAIR IMPROVED""

      ```

* Compute the row and column movement steps for the Enterprise.

  This gets interesting.

  First, all nav directions correspond to row and column offsets for
  movement. For example, direction `2` requires you to add `-1` to the
  row and `1` to the column:

  ```
           (-1,0)
    (-1,-1)       (-1,1)
           4  3  2
            \ | /
             \|/
  (0,-1) 5 ---*--- 1 or 9 (0,1)
             /|\
            / | \
           6  7  8
     (1,-1)       (1,1)
            (1,0)
  ```

  But you can also set a fractional course, e.g. `1.25`. What are the
  movement offsets in that case?

  The row and column offset are computed by looking at the requested
  integer course and the _next_ integer course. e.g. for `1.25`, the
  math will look at the offsets for courses `1` and `2`.

  A course of `8.xx` will look at courses `8` and `9`, where `9` is the
  same as `1`.

  The fractional part of the course will then be used to LERP between
  row or column values depending on the direction chosen.

  Let's encode the above table into 1-based arrays:
  
  ```
  course_row_offset = [0,-1,-1,-1,0,1,1,1,0]   # 1-based!
  course_col_offset = [1,1,0,-1,-1,-1,0,1,1]
  ```

  Break the requested course into whole and fractional components. The
  fraction will later be used to LERP between two whole directions.

  ```
  int_course = int(course)    # Whole number part, e.g. `1`
  frac_course = frac(course)  # Fractional part, e.g `0.25`
  ```

  Compute the next course up from the requested one:

  ```
  next_course = int_course + 1 # Whole number next course up, e.g. `2`.
  ```

  Compute the differences in row and col offsets between this whole
  course and the next whole course. It's important to note that one of
  these is always zero.

  ```
  row_offset_diff = course_row_offset[next_course] - \
                    course_row_offset[int_course]

  col_offset_diff = course_col_offset[next_course] - \
                    course_col_offset[int_course]
  ```

  Compute the LERPed row and column diffs, based on the fractional part
  of the requested direction. Note that one of these is always zero.

  ```
  row_offset_diff_lerp = row_offset_diff * frac_course
  col_offset_diff_lerp = col_offset_diff * frac_course
  ```

  Compute how much to add to Enterprise's sector row and column each
  step. One of these will have an absolute value of `1`, and the other
  will have an absolute value in the range `[0,1]`.

  ```
  row_step = course_row_offset[int_course] + row_offset_diff_lerp
  col_step = course_colcocolet[int_course] + col_offset_diff_lerp
  ```

  These are the values that we'll move the Enterprise each step.

* Move the Enterprise.

  Remember when we computed the energy needed for the maneuver way up
  there? Refresher:

  ```
  energy_needed = int(warp_factor * 8 + .5)
  energy_needed = round_nearest(warp_factor * 8)  // same thing
  ```

  We're going to loop that many times.

  ```
  loop_count = energy_needed
  ```

  * Loop `loop_count` times:

    * Add `row_step` to Enterprise's current row. (Might have a
      fractional result.)

    * Add `col_step` to Enterprise's current column. (Might have a
      fractional result.)

    * If the Enterprise has moved out of the quadrant:

      Jump to [Move Between Quadrants](#routine--move-between-quadrants)
      code.

    * Check to see if the new sector already has something in it. If it
      does, don't move the Enterprise there, and print an error message:

      ```
      WARP ENGINES SHUT DOWN AT SECTOR s , s DUE TO BAD NAVIGATION
      ```

      Break out of this loop.

  * Truncate any fractional part of the Enterprise's row and column
    values.

  * Call subroutine [Subtract Energy](#subroutine--subtract-energy).

  * Place the Enterprise in its new position on the map.

* Compute the stardates it took to move.

  If the warp factor was greater than or equal to `1`, add `1` to the
  current stardate.

  If the warp factor was less than `1`, then compute the warp factor
  rounded to the nearest tenth. Add that to the current stardate.

* Determine if the game is over.

  If the current stardate is greater than the starting stardate plus the
  game length, jump to [Game Over (intact)](#game-over--intact-).

* Jump to [Start of Main Loop with SRS](#order-of-play).

## Subroutine: Subtract Energy

* Subtract the `energy_needed` for the warp maneuver from the
  Enterprise's main energy.

* If the main energy is less than `0`:

  * Print a message:

    ```
    SHIELD CONTROL SUPPLIES ENERGY TO COMPLETE THE MANEUVER.
    ```

  * Add main energy (which is negative) to the shield energy.

  * If the shield energy is less than `0`, clamp it to `0`.

* Return to caller.

## Routine: Move Between Quadrants

When traveling between quadrants, we're not concerned with hitting
anything. We're just going to compute the destination.

First, get the complete `row_step` and `col_step` (in sectors) for the
entire move by multiplying those steps by `loop_count`:

```
total_row_step = loop_count * row_step
total_col_step = loop_count * row_col
```

Figure out our start coordinates in sector space by multiplying the
quadrant coordinates by `8` and adding on our sector coordinates:

```
sector_space_row = quadrant_row * 8 + sector_row
sector_space_col = quadrant_col * 8 + sector_col
```

Add on the total steps to get to our new destination:

```
sector_space_new_row = sector_space_row + total_row_step
sector_space_new_col = sector_space_col + total_col_step
```

Compute the new quadrant by dividing our sector by `8` and throwing away
the fractional part:

```
new_quadrant_row = int(sector_space_new_row / 8)
new_quadrant_col = int(sector_space_new_col / 8)
```

Compute the new sector coordinates within the quadrant (back to quadrant
space):

```
new_sector_row = int(sector_space_new_row - new_quadrant_row * 8)
new_sector_col = int(sector_space_new_col - new_quadrant_col * 8)
```

There's a chance this might end up with zero values for the row or
column. Since we're 1-based for everything, foolishly, we have to deal
with it:

* If the sector row is `0`, set it to `8` and subtract `1` from the new
  quadrant row.

* If the sector column is `0`, set it to `8` and subtract `1` from the
  new quadrant column.

> A lot of this nastiness can be avoided if you just used zero-based
> locations internally and changed them to 1-based on presentation.

TODO BASIC line 3620

