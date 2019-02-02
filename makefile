######################
# Makefile for Latex #
######################
      SRC_NAME = main
           SRC = $(SRC_NAME).tex
     INPUT_SRC = $(SUB_SRC_NAME).tex
      AUX_FILE = ${SRC_NAME}.aux
      BBL_FILE = ${SRC_NAME}.bbl
      BLG_FILE = ${SRC_NAME}.blg
      DVI_FILE = ${SRC_NAME}.dvi
      LOF_FILE = ${SRC_NAME}.lof
      LOG_FILE = ${SRC_NAME}.log
      LOT_FILE = ${SRC_NAME}.lot
      TOC_FILE = ${SRC_NAME}.toc
      GLO_FILE = $(SRC_NAME).glo
      GLS_FILE = $(SRC_NAME).gls
      LOA_FILE = $(SRC_NAME).loa
      ILG_FILE = $(SRC_NAME).ilg
      ENT_FILE = $(SRC_NAME).ent
       RM_FILE = ${AUX_FILE} ${BBL_FILE} ${BLG_FILE} \
                 ${LOF_FILE} ${LOG_FILE} ${LOT_FILE} \
                 ${LOA_FILE} ${GLS_FILE} ${GLO_FILE} \
                 ${TOC_FILE} ${DVI_FILE} ${ILG_FILE} ${ENT_FILE} \
                 core *~ *.log *.aux *.bmc *.pbm *.pfi

         LATEX = platex
     MAKEINDEX = mendex
        BIBTEX = jbibtex
       OUT2UNI = out2uni
       DVIPDFM = dvipdfmx
            RM = rm -f

.SUFFIXRS : .tex

all :
	$(RM) $(RM_FILE)
	$(LATEX) $(SRC_NAME)
	$(BIBTEX) $(SRC_NAME)
	$(MAKEINDEX) $(GLO_FILE) -s esysnomencl.ist -o $(GLS_FILE)
	$(LATEX) $(SRC_NAME)
	$(LATEX) $(SRC_NAME)

pdf :
	$(RM) $(RM_FILE)
	$(LATEX) $(SRC_NAME)
	$(BIBTEX) $(SRC_NAME)
	$(MAKEINDEX) $(GLO_FILE) -s esysnomencl.ist -o $(GLS_FILE)
	$(LATEX) $(SRC_NAME)
	$(LATEX) $(SRC_NAME)
	$(DVIPDFM) $(SRC_NAME)

oldpdf :
	$(RM) $(RM_FILE)
	$(LATEX) $(SRC_NAME)
	$(BIBTEX) $(SRC_NAME)
	$(MAKEINDEX) $(GLO_FILE) -s esysnomencl.ist -o $(GLS_FILE)
	$(LATEX) $(SRC_NAME)
	$(LATEX) $(SRC_NAME)
	$(DVIPDFM) $(SRC_NAME)

out :
	$(RM) $(RM_FILE)
	$(LATEX) $(SRC_NAME)
	$(BIBTEX) $(SRC_NAME)
	$(MAKEINDEX) $(GLO_FILE) -s esysnomencl.ist -o $(GLS_FILE)
	$(LATEX) $(SRC_NAME)
	$(LATEX) $(SRC_NAME)
	$(OUT2UNI) $(SRC_NAME)
	$(LATEX) $(SRC_NAME)
	$(DVIPDFM) $(SRC_NAME)

clean:
	@ $(RM) $(RM_FILE)


