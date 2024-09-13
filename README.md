# DesTestMini

A tiny ROM-based diagnostic for the C64 that affords the best opportunity to see if at least the processor is executing instructions.

## Why
A C64 might show a black screen for many reasons.  Knowing where to start can be a little daunting.  Try this first.

This small diagnostic can be used to determine if at least the CPU is running, and that's a good start.
No assumptions are made about the state of the machine: The ROMs, RAM, CIAs, Colour RAM and SID need not be present.

## MAX mode
For this diagnostic to work the resulting binary will be burned on to an EPROM (or equivalent) and put into a
standard C64 cartridge which is configured for MAX mode.

A MAX mode cartridge allows the code on the EPROM to be executed as soon as the machine is powered on.  This is
extremely useful for diagnostics cartridges since it means that it can bypass the normal initialization routines
that could fail in the face of faulty hardware.

Bare C64 cartridges and pcb designs (such as the VersaCart) can easily be found on the internet and can likely be
ordered directly from the larger PCB manufacturers (on their Shared Projects or equivalent page).

Configure your new cartridge to MAX mode by ensuring that the /GAME signal is grounded (set to 0).

## How
The 6510 in your '64 connects to the cassette write and cassette-motor signal almost directly.  This arrangement offers a great oppprtunity to see if the CPU is running while not relying on much of the other components.

The code presented here continuously toggles the cassette-write and cassette-motor signals on for 1 second then off for 1 second. That's it.

If you have a 1530/C2N datassette then simply attatch it, plug in your new cartridge, power on your C64 and press PLAY.  No cassette is necessary.  If the cassette drive sproket spins for a second then stops for a second repeatedly then your C64 is indeed executing instructions.

If you don't have a datassette then you can probe the cassette interface directly with a multimeter.  Measure the voltage between the GND (left most conductor when looking from behind, top or bottom) and WRITE (second conductor from the right when looking from behind, top or bottom). If the
voltage swaps between 0 volts and 5 volts each for 1 second repeatedly then your C64 is executing instructions.

### VIC-II
The option exists to enable flashing the VIC screen as a visual indication that the CPU is running.  This may not always be reliable as it is possible that some bad components (address bus muxes) can block the CPU from reaching the VIC to change the screen colour.

### SID
The option also exists to have the SID emit alternating tones as a sonic indication that the CPU is running.  SID chips are not the most reliable of ICs so not hearing anything isn't necessarily and indication of the CPU not running.
