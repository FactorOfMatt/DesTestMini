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

Configure your new cartridge to MAX mode by ensuring that the /GAME signal is grounded (set to 0) and that the EPROM is attached as /ROMH.

## How
The 6510 in your '64 connects to the cassette write and cassette-motor signal almost directly.  This arrangement offers a great oppprtunity to see if the CPU is running while not relying on much of the other components.

The code presented here continuously toggles the cassette-write and cassette-motor signals on for 1 second then off for 1 second. That's it.

If you have a 1530/C2N datassette then simply attatch it, plug in your new cartridge, power on your C64 and press PLAY.  No cassette is necessary.  If the cassette drive sprocket spins for a second then stops for a second repeatedly then your C64 is indeed executing instructions.

If you don't have a datassette then you can probe the cassette interface directly with a multimeter.  Measure the voltage between the GND (left most conductor when looking from behind, top or bottom) and WRITE (second conductor from the right when looking from behind, top or bottom). If the
voltage swaps between 0 volts and about 5 volts each for 1 second repeatedly then your C64 is executing instructions.

#### LED
Alternatively you can attach and LED and 390R resistor between the GND and MOTOR conductors.  The LED has to be
attached between the GND and MOTOR conductors in the correct polarity.  The cathode (short-leg, flat-side) of
the LED should attach to the GND conductor and the anode (long-leg) of the LED should attach via the resistor
to the MOTOR conductor.
Note 1: the resistor can attach to either the cathode or anode.
Note 2: the WRITE signal can also be used however it is connected directly to the 6510 and won't supply as
        much current to light the LED.
Note 3: The value for the resistor (390R) should work for most red LEDs, but can be substitued as necessary
for different LEDs.  The voltage of the MOTOR signal is about 10V with no load.

    1 2 3 4 5 6   C64 cassette-port (viewed from the rear)
    -----------  
    A B C D E F   The top and bottom conductors carry the same signals.  

    F-6 SENSE   x  
    E-5 WRITE   x  
    D-4 READ    x   390R  
    C-3 MOTOR   o--/\/\/\----|  
    B-2 +5V     x   | /|     |  
    A-1 GND     o---|< |-----|  
                  - | \| +  
                     LED  

You can use small crocodile or alligator clip to attach to the GND and WRITE, just be sure to only touch the
copper trace (top and bottom) of the signal you are after.

If you wish to make your LED fixture more permanent you can buy a 6-pin 0.156-inch edge connector from your
favourite online electronic components retailer. Simply solder the LED/resistor to the appropriate pins on
the edge connector.  Be sure to clearly write the word "TOP" on your new fixture as plugging it in upside-down
may cause damage to your 6510.
  ![Simple LED fixture](pics/fixture.jpg)

### VIC-II
The option exists to enable flashing the VIC screen as a visual indication that the CPU is running.  This may not always be reliable as it is possible that some bad components (address bus muxes) can block the CPU from reaching the VIC to change the screen colour.

### SID
The option also exists to have the SID emit alternating tones as a sonic indication that the CPU is running.  SID chips are not the most reliable of ICs so not hearing anything isn't necessarily and indication of the CPU not running.
