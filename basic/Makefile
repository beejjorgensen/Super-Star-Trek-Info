all: sst.bas sst_inst.bas

sst.bas: sst_annotated.bas
	grep -E '^[0-9]' $^ > $@

sst_inst.bas: sst_inst_annotated.bas
	grep -E '^[0-9]' $^ > $@

.PHONY: diff

diff: sst.bas
	vimdiff sst.bas sst_vintagebasic.bas
