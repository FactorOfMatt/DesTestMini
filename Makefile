# Makefile for DesTestMini
#
# This Makefile assumes a unix/linux environment.  Conversion to a different environment
# should be straightforward and is left as an exercise for the reader.

all: destestmini.rom destestmini-nosid.rom destestmini-novic.rom destestmini-novic-nosid.rom

ASM=dasm # I've used an ancient version of Dillon's marvellous assembler I've maintained over the years.
ASM_OPTS=-f3 -v0 # adjust this to suit your assembler.  The output should be 8192 bytes, no header.
VERSION=0.1

# create date and version file
date.src:
	@date +"DATE equ \"%d %b %Y\"" >date.src

version.src:
	@echo "VERSION equ \"$(VERSION)\"" >version.src

# construct the default version (with SID and VIC)
destestmini.rom: destestmini.src date.src version.src Makefile
	$(ASM) $< $(ASM_OPTS) -l$(basename $@).lis -o$@ -DTRY_VIC=1 -DTRY_SID=1
	@cat $@ $@ > $(basename $@)_vice.rom

# construct the no-vic version
destestmini-novic.rom: destestmini.src Makefile
	$(ASM) $< $(ASM_OPTS) -l$(basename $@).lis -o$@ -DTRY_VIC=0
	@cat $@ $@ > $(basename $@)_vice.rom

# construct the no-sid version
destestmini-nosid.rom: destestmini.src Makefile
	$(ASM) $< $(ASM_OPTS) -l$(basename $@).lis -o$@ -DTRY_SID=0
	@cat $@ $@ > $(basename $@)_vice.rom

# construct the no-vic, no-sid version
destestmini-novic-nosid.rom: destestmini.src Makefile
	$(ASM) $< $(ASM_OPTS) -l$(basename $@).lis -o$@ -DTRY_VIC=0 -DTRY_SID=0
	@cat $@ $@ > $(basename $@)_vice.rom

test: destestmini.rom
	x64 -default -ntsc -cartultimax destestmini_vice.rom

test-novic: destestmini-novic.rom
	x64 -default -ntsc -cartultimax destestmini-novic_vice.rom

test-nosid: destestmini-novic.rom
	x64 -default -ntsc -cartultimax destestmini-nosid_vice.rom

test-novic-nosid: destestmini-novic.rom
	x64 -default -ntsc -cartultimax destestmini-novic-nosid_vice.rom

release: destestmini.rom destestmini-novic.rom destestmini-nosid.rom destestmini-novic-nosid.rom \
    destestmini_vice.rom destestmini-novic_vice.rom destestmini-nosid_vice.rom destestmini-novic-nosid_vice.rom \
	LICENSE.txt README.md
	rm -f destest-mini-v$(VERSION).zip
	zip -j destest-mini-v$(VERSION).zip $^


clean:
	@rm -f *.rom *.lis date.src version.src
