// code written by Beatrice Saviozzi
class States {
  int x, y;
  int event;
  int numberClickS = 0;

  States(int x, int y, int event) {
    this.x = x;
    this.y = y;
    this.event = event;
    background(0);
  }

  void setup () {
    for (int i = 50; i < 100; i++) {
      isSelectedState[i] = false;
    }
  }

  void draw() {
    if (isSelectedState[event] && !isSelected[EVENT_GOBACK]) {
      fill(0);
    } else {
      fill(255);
    }
    stroke(0);
    rect(x, y, 20, 20);
    if (isSelected[EVENT_MAP])
    {
      numberClickS = 0;
    }
  }

  int getEvent(int mX, int mY) {
    if (mX > x && mX < x+20 && mY > y && mY < y+20) {
      return event;
    }
    return EVENT_NULL;
  }

  void setColor(int index)
  {
    isSelected[EVENT_GOBACK] = false;
    isSelectedState[index] = true;
    for (int i = 50; i < 100; i++) {
     if(i != index) isSelectedState[i] = false;
    }
  }
  
  // when the button is pressed on a state, the program will perfom different actions - beatrice 26/03
  void clicked(int event) {
    switch(event) {
    case EVENT_WASH:
      println("washington");
      setColor(EVENT_WASH);
      airports = "BLI|GEG|SEA|PAE|PSC|PUW|ALW|EAT|YKM";
      break;
    case EVENT_ORE:
      println("oregon");
      setColor(EVENT_ORE);
      airports = "RDM|OTH|EUG|MFR|PDX";
      break;
    case EVENT_CAL:
      println("california");
      setColor(EVENT_CAL);
      airports = "BUR|FAT|LAX|LBG|OAK|ONT|SAN|RSP|SCK|SFO|SJC|SMF|SMX|SNA";
      break;
    case EVENT_MON:
      println("montana");
      setColor(EVENT_MON);
      airports = "BIL|BZN|BTM|GTF|HLN|FCA|MSO";
      break;
    case EVENT_IDA:
      println("idaho");
      setColor(EVENT_IDA);
      airports = "IDA|BOI|LWA|PIH|SUN|TWF";
      break;
    case EVENT_NEV:
      println("nevada");
      setColor(EVENT_NEV);
      airports = "EKO|LAS|RNO";
      break;
    case EVENT_UTH:
      println("utah");
      setColor(EVENT_UTH);
      airports = "CDC|CNY|OGD|PVU|SLC|SGU|VEL";
      break;
    case EVENT_ARIZ:
      println("arizona");
      setColor(EVENT_ARIZ);
      airports = "FLG|AZA|PHX|PRC|TUS|YUM";
      break;
    case EVENT_WYO:
      println("wyoming");
      setColor(EVENT_WYO);
      airports = "CPR|CYS|COD|GCC|JAC|LAR|RIW|RSK|SHR";
      break;
    case EVENT_COL:
      println("colorado");
      setColor(EVENT_COL);
      airports = "ALS|ASE|COS|DEN|DRO|EGE|GJT|GUC|HDN|MTJ|PUB";
      break;
    case EVENT_NMEX:
      println("new mexico");
      setColor(EVENT_NMEX);
      airports = "ABQ|HOB|ROW|SAF";
      break;
    case EVENT_TEX:
      println("texas");
      setColor(EVENT_TEX);
      airports = "ABI|AMA|AUS|BPT|BRO|CLL|CRP|DAL|DFW|DRT|ELP|HRL|HOU|IAH|GRK|LRD|GGG|LBB|MAF|MFE|SJT|SAT|TYR|VCT|ACT|SPS";
      break;
    case EVENT_OKL:
      println("oklahoma");
      setColor(EVENT_OKL);
      airports = "LAW|OKC|SWO|TUL";
      break;
    case EVENT_KAN:
      println("kansas");
      setColor(EVENT_KAN);
      airports = "DDC|GCK|GCK|HYS|LBL|MHK|SLN|ICT";
      break;
    case EVENT_NEBR:
      println("nebraska");
      setColor(EVENT_NEBR);
      airports = "GRI|EAR|LNK|LBF|OMA|BFF";
      break;
    case EVENT_SDAK:
      println("south dakota");
      setColor(EVENT_SDAK);
      airports = "ABR|PIR|RAP|FSD|ATY";
      break;
    case EVENT_NDAK:
      println("north dakota");
      setColor(EVENT_NDAK);
      airports = "BIS|DVL|FAR|GFK|JMS|MOT|XWA";
      break;
    case EVENT_MIN:
      println("minnesota");
      setColor(EVENT_MIN);
      airports = "BJI|BRD|DLH|HIB|INL|MSP|RST|STC";
      break;
    case EVENT_IOWA:
      println("iowa");
      setColor(EVENT_IOWA);
    airports = "CID|DSM|DBQ|FOD|MCW|SUX|ALO";
      break;
    case EVENT_MISS:
      println("missouri");
      setColor(EVENT_MISS);
      airports = "CGI|COU|TBN|JLN|MCI|SGF|STL";
      break;
    case EVENT_ARK:
      println("arkansas");
      setColor(EVENT_ARK);
      airports = "XNA|FSM|LIT|TXK";
      break;
    case EVENT_LOUI:
      println("lousiana");
      setColor(EVENT_LOUI);
      airports = "AEX|BTR|LFT|LCH|MLU|MSY|SHV";
      break;
    case EVENT_MIPP:
      println("mississipi");
      setColor(EVENT_MIPP);
      airports = "GTR|GPT|PIB|JAN|MEI";
      break;
    case EVENT_ILL:
      println("illinois");
      setColor(EVENT_ILL);
      airports = "BLV|BMI|CMI|MDW|ORD|DEC|MLI|PIA|RFD|SPI";
      break;
    case EVENT_WIS:
      println("wisconsin");
      setColor(EVENT_WIS);
      airports = "ATW|EAU|GRB|LSE|MSN|MKE|CWA|RHI";
      break;
    case EVENT_MICH:
      println("michigan");
      setColor(EVENT_MICH);
      airports = "APN|DTW|ESC|FNT|GRR|CMX|IMT|AZO|LAN|MQT|MKG|PLN|MBS|CIU|TVC";
      break;
    case EVENT_IND:
      println("indiana");
      setColor(EVENT_IND);
      airports = "EVV|FWA|IND|SBN";
      break;
    case EVENT_KEN:
      println("kentucky");
      setColor(EVENT_KEN);
      airports = "CVG|LEX|SDF|OWB|PAH";
      break;
    case EVENT_TEN:
      println("tennessee");
      setColor(EVENT_TEN);
      airports = "TRI|CHA|TYS|MEM|BNA";
      break;
    case EVENT_ALAB:
      println("alabama");
      setColor(EVENT_ALAB);
      airports = "BHM|DHN|HSV|MOB|MGM";
      break;
    case EVENT_FLO:
      println("florida");
      setColor(EVENT_FLO);
      airports = "DAB|FLL|RSW|GNV|JAX|EYW|MLB|MIA|MCO|ECP|PNS|PGD|SFB|SRQ|PIE|TLH|TPA|VPS|PBI";
      break;
    case EVENT_GEO:
      println("georgia");
      setColor(EVENT_GEO);
      airports = "ABY|ATL|AGS|BQK|CSG|SAV|VLD";
      break;
    case EVENT_OHI:
      println("ohio");
      setColor(EVENT_OHI);
      airports = "CAK|CLE|CMH|LCK|DAY|TOL";
      break;
    case EVENT_PENN:
      println("pennsylvania");
      setColor(EVENT_PENN);
      airports = "ABE|ERI|MDT|JST|LBE|PHL|PIT|AVP|SCE";
      break;
    case EVENT_NY:
      println("new york");
      setColor(EVENT_NY);
      airports = "ALB|BGM|BUF|ELM|ISP|ITH|JFK|LGA|SWF|IAG|OGS|PBG|ROC|SYR|ART|HPN";
      break;
    case EVENT_MASS:
      println("massachusetts");
      setColor(EVENT_MASS);
      airports = "BOS|ORH";
      break;
    case EVENT_VER:
      println("vermont");
      setColor(EVENT_VER);
      airports = "BVT";
      break;
    case EVENT_NHAM:
      println("new hamshire");
      setColor(EVENT_NHAM);
      airports = "MHT|PSM";
      break;
    case EVENT_MAI:
      println("maine");
      setColor(EVENT_MAI);
      airports = "BGR|PWM|PQI";
      break;
    case EVENT_RI:
      println("rhode island");
      setColor(EVENT_RI);
      airports = "PDV";
      break;
    case EVENT_CONN:
      println("connecticut");
      setColor(EVENT_CONN);
      airports = "BDL";
      break;
    case EVENT_NJER:
      println("new jersey");
      setColor(EVENT_NJER);
      airports = "ACY|EWR|TTN";
      break;
    case EVENT_DELA:
      println("delaware");
      setColor(EVENT_DELA);
      airports = "ILG";
      break;
    case EVENT_MARY:
      println("maryland");
      setColor(EVENT_MARY);
      airports = "BWI|HGR|SBY";
      break;
    case EVENT_WVIR:
      println("west virginia");
      setColor(EVENT_WVIR);
      airports = "HTS|CRW|CKB|LWB";
      break;
    case EVENT_VIR:
      println("virginia");
      setColor(EVENT_VIR);
      airports = "CHO|LYH|PHF|ORF|RIC|ROA|SHD|DCA|IAD";
      break;
    case EVENT_NCAR:
      println("north carolina");
      setColor(EVENT_NCAR);
      airports = "AVL|CLT|USA|FAY|GSO|PGV|OAJ|EWN|RDU|ILM";
      break;
    case EVENT_SCAR:
      println("south carolina");
      setColor(EVENT_SCAR);
      airports = "CHS|CAE|FLO|GSP|HHH|MYR";
      break;
    case EVENT_AL:
      println("alaska");
      setColor(EVENT_AL);
      airports = "ADK|ANC|BRW|BET|CDV|SCC|DLG|FAI|JNU|KTN|AKN|OTZ|OME|PSG|SIT|WRG|YAK";
      break;
    case EVENT_HAW:
      println("hawaii");
      setColor(EVENT_HAW);
      airports = "ITO|HNL|OGG|KOA|LIH";
      break;
    }
  }
}
