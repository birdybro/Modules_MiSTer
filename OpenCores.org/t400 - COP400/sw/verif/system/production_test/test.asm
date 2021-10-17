	;; *******************************************************************
	;; $Id: test.asm 179 2009-04-01 19:48:38Z arniml $
	;;
	;; Production test as proposed by
	;;   "Testing of COP400 Familiy Devices"
	;;   National Semiconductor
	;;   COP Note 7
	;;   April 1991
	;;

	;; the cpu type is defined on asl's command line

	org	0x00

;	INSTRUCTION		  RESULT	COMMENTS

	NOP			; NO CHANGE	CHECK NOP & ALLOW TRANSIENT
				;		CYCLE FOR MODE
	OGI	9		; G(0 > 9)	NOT FOR 410L/411L
	OGI	6		; G(9 > 6)	REVERSE ALL G STATES
	STII	8		;		SET UP 0,0 FOR FUTURE
	LBI	3, 13		;		B TO NEW POSITION (3, 13)
	OBD			; D(0 > 13)	CHECK D
	CLRA			;		MAKE SURE A = 0
	XABR			;		3 > A;0 > Br
	CAB			;		MOVE 3 to Bd
	OBD			; D(13 > 3)	CHECK XABR CAB & D CHANGE
	CLRA			;		!
	AISC 	2		;		!FORCE A > 2
	CAB			;		2 > Bd
	OBD			; D(3 > 2)	VERIFY 2 FROM A > Bd
	STII	7		;		7 > 0,2 & Bd > 3
	OBD			; D(2 > 3)	STII INCREMENTS Bd
	CAB			;		SEE THAT A STILL THE SAME
	OMG			; G(6 > 7)	OMB & RAM CHECK
	CLRA
	CAB			;		B(0,0)
	OMG			; G(7 > 8)	TIE IN RAM, A & G OPERATION
	SMB	0		;		SMB INST. CHECK
	OMG			; G(8 > 9)	:
	SMB	1		;		:
	OMG			; G(9 > 11)	:
	RMB	0		;		:
	RMB	3		;		:
	LD	0		;		:2 > A (modified AL)
	CAB			;		A = 2 > B
	OMG			; G(11 > 7)	OUTPUT M(0,2)
	LD	1		;		M(0,2) > A; B > 1,2
	XAD	0,0		;		A(7) < => M(0,0) 2
	AISC	15		;		AISC CHECK; A = 1
	LDD	0,0		;		CHECK SKIP OF 2 BYTE INST.
	X	0		;		STORE 1
	OMG			; G(7 > 1)	VERIFY
	LD	0		;		COPY1,2 BACK TO A
	ADT			;		ADD TEN
	XDS	0		;		LEAVE 11 IN 1,2;GO 1, 1 WITH 1
	XDS	0		;		LEAVE 1 IN 1,1;GO 1,0 W ?
	OBD			; D(2 > 0)	CHECK Bd MOVEMENT
	STII	5		;		5 > 1,0;Bd TO 1,1
	CBA			;		CHECK B > A
	AISC	3		;		AISC CHECK 4 >A

;	INSTRUCTION		  RESULT	COMMENTS

	XDS	0		;		1 > A; 4 > 1,1
	OMG			; G(1 > 5)	FROM 1,0
	XDS	0		;		5 > A; 1 > 1,0; Bd < 15 SKIP
	LDD	0,0		;		SKIPPED !
	OBD			; D(0 > 15)
	AISC	4		;		9 > A
	X	0		;		9 > 15
	OMG			; G(5 > 9)
	CLRA
	COMP			;		ONES TO A
	XOR			;		FLIP MEMORY
	XIS	0		;		6 > 1,15; 9 > A; Bd > 1,0
	LDD	0,0		;		SKIP
	AISC	8		;		A > 1 (added AL)
	LDD	0,0		;		SKIP  (added AL)
	SKE
	LBI	1,2		;		SKIP 2 WORD LBI (NOT IN 410)
	OBD			; D(15 > 0)	VERIFY WORD
	SKE			;		11 NOT = 9
	LBI	1,0		;		BACK TO 1,0
	SMB	2		;		:
	SKE			;		:
	RMB	2		;		:
	SKE			;		:CHECK BIT
	SMB	3		;		:MANIPULATIONS
	SKE			;		:
	LDD	0,0		;		:
	X	3		;		Bd > 2,0
	XAD	1,1		;		9 > 1,1; 4 > A
	XIS	1		;		4 > 2,0; Bd > 3,1
	ING			;		INPUT G PORT
	X	0		;		STORE

;	INSTRUCTION		  RESULT	COMMENTS

	CLRA
	ASC			;		CHECK ADD WITH CARRY
	SC			;		CHECK SET CARRY
	SKC			;		CHECK SKIP ON CARRY
	LDD	0,0
	X	0		;		STORE A
	OMG			; G = 9		NO CHANGE
	CLRA
	ASC
	X	0
	OMG			; G(9 > 10)	CARRY ADDS ONE TO MEMORY
	CAMQ			;		STORE A & M IN Q; 10,9
	XDS	0		;		9 > 3,1; 10 > A; Bd > 3,0
	CQMA			;		STORE 9 IN 3,0 (added AL)
	OMG			; G(10 > 9)
	LD	2		;		9 > A; Bd > 1,0

;	INSTRUCTION		  RESULT	COMMENTS

	OMG			; G(9 > 1)
	LD	3		;		1 > A; Bd > 2,0
	OMG			; G(1 > 4)      (result corrected AL)
	ADD			;		ADD WITHOUT CARRY
	X	0		;		STORE 3 IN 2,0
	SC
	LDD	0,0		;		7 > A
	CASC			;		CHECK CASC
	SKC
	X	0		;		STORE 12
	OMG			; G(4 > 14)     (prev and current result corrected AL)
	CLRA			;		:
	AISC	3		;		:
	X	0		;		:
	SC			;		:CHECK
	SKC			;		:SKC/SC
	X	0		;		:
	OMG			; G(14 > 3)	(prev result corrected AL)
	RC			;		:
	SKC			;		:CHECK
	X	0		;		:RC
	OMG			; G(3 > 14)	:
	LBI	0,0		;		:CHECK
	LBI	1,15		;		;SEQUENTIAL LBI'S
	LBI	2,7		;		ALSO SKIPPED (LBI 2,7 NOT IN 410)
	OMG			; G(14 > 7)
	CQMA			;		LOAD CONSTANTS FROM Q
	OMG			; G(7 > 9)	CHECK
	X	0		;		:
	OMG			; G(9 > 10)	:
	LEI	1
	XAS			;		STORE A - > S (9)
	CLRA
	AISC	7		;		:
	SKGBZ	0		;		:
	X	0		;		:CHECK
	OMG			;		:
	SKGBZ	1		;		:
	X	0		;		;G BIT
	OMG			; G (10 > 7)	:
	SKGBZ	2		;		:
	X	0		;		:
	OMG			; G(7 > 10)	:TESTS
	SKGBZ	3		;		:
	X	0		;		:
	OMG			; G(10 > 7)	:

;	INSTRUCTION		  RESULT	COMMENTS

	SKGZ
	X	0		;		:CHECK
	OMG			; G(7 > 10)	:
	OGI	0		; G(10 > 0)	:G TEST
	SKGZ			;		:
	X	0		;		:
	OMG			; G(0 > 10)	:
	SKMBZ	0
	X	0		;		CHECK MEMORY BIT TESTS
	OMG			;		NO CHANGE
	SKMBZ	1

;	INSTRUCTION		  RESULT	COMMENTS

	X	0
	OMG			; G(10 > 7)	NO SKIP
	SKMBZ	2
	X	0		;		WON'T SKIP
	OMG			; G(7 > 10)
	INIL			;		SEE THAT L LATCHES RESET
	ININ			;		ASSUME G - > I
	SKE
	X	1		;		Br > 1
	OMG			;		SHOULD BE EQUAL
	INIL			;		:
	X	0		;		:
	SKMBZ	3		;		:
	OBD			; D(15 > 0)	:INIL TEST
	OGI	1		; G(10 > 1)	:(result added AL)
	LBI	3,11		;		:
	OGI	0		; G(1 > 0)	:(result added AL)
	NOP			;		(NOP added AL)
	INIL			;		:
	X	0		;		:
	SKMBZ	0		;		:
	OBD			; D(0 > 11)	:
	NOP
	XAS			;		:
	X	0		;		:XAS TEST
	OMG			; G(10 > 9)	:

;	INSTRUCTION		  RESULT	COMMENTS

	LBI	0,0		;		LOAD RAM WITH
	STII	7		;		CONSTANTS USING
	STII	14		;		STII
	STII	5
	STII	12
	STII	3
	STII	10
	STII	1
	STII	8
	STII	15
	STII	6
	STII	13
	STII	4
	STII	11
	STII	2
	STII	9
	STII	0
	LBI	1,0
	STII	7
	STII	14
	STII	5
	STII	12
	STII	3
	STII	10
	STII	1
	STII	8
	STII	15
	STII	6
	STII	13
	STII	4
	STII	11
	STII	2
	STII	9
	STII	0
	LBI	2,0
	STII	7
	STII	14
	STII	5
	STII	12
	STII	3
	STII	10
	STII	1
	STII	8
	STII	15
	STII	6
	STII	13

;	INSTRUCTION		  RESULT	COMMENTS

	STII	4
	STII	11

;	INSTRUCTION		  RESULT	COMMENTS

	STII	2
	STII	9
	STII	0
	LBI	3,0
	STII	7
	STII	14
	STII	5
	STII	12
	STII	3
	STII	10
	STII	1
	STII	8
	STII	15
	STII	6
	STII	13
	STII	4
	STII	11
	STII	2
	STII	9
	STII	0

;	INSTRUCTION		  RESULT	COMMENTS

	LBI	0,0		;		CHECK FOR RAM DATA
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	NOP

;	INSTRUCTION		  RESULT	COMMENTS

	LBI	1,0		;		CHECK FOR RAM DATA
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT

;	INSTRUCTION		  RESULT	COMMENTS

	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	NOP

;	INSTRUCTION		  RESULT	COMMENTS

	LBI	2,0		;		CHECK FOR RAM DATA
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT

;	INSTRUCTION		  RESULT	COMMENTS

	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	NOP

;	INSTRUCTION		  RESULT	COMMENTS

	LBI	3,0		;		CHECK FOR RAM DATA
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	OMG			;		OUTPUT DATA
	LD	0		;		:
	XIS	0		;		:MOVE TO NEXT DIGIT
	NOP

	jmp	.