AS = wla-6502
LD = wlalink
LDFLAGS = -S
LINKFILE = linkfile

ASM = hack.asm
ROM = castlevania3.nes
OBJ = hack.o
HACK = hack.nes

$(HACK): $(OBJ)
	$(LD) $(LDFLAGS) $(LINKFILE) $@

$(OBJ): $(ASM)
	$(AS) -o $@ $<

.PHONY:
clean:
	rm -rf *.o $(HACK)
