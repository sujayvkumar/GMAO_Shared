import my_utils as utl
import scipy as sp
import datetime
import dateutil.rrule as rrule

class Ctl(utl.Dset):
    def __init__(self):
        self.name='GFDL'
        self.undef=1.e+20

        self.flist=sp.array(['/discover/nobackup/yham/GFDL/vo/gfdl_cm2_1.gdat'])

        lon=sp.arange(0.1,360.1,1.)
        lat=sp.array((-81.5, -80.5, -79.5, -78.5, -77.5, -76.5, -75.5, -74.5, -73.5, -72.5, \
                      -71.5, -70.5, -69.5, -68.5, -67.5, -66.5, -65.5, -64.5, -63.5, -62.5, \
                      -61.5, -60.5, -59.5, -58.5, -57.5, -56.5, -55.5, -54.5, -53.5, -52.5, \
                      -51.5, -50.5, -49.5, -48.5, -47.5, -46.5, -45.5, -44.5, -43.5, -42.5, \
                      -41.5, -40.5, -39.5, -38.5, -37.5, -36.5, -35.5, -34.5, -33.5, -32.5, \
                      -31.5, -30.5, -29.5, -28.5014258562951, -27.507104884679, \
                      -26.5197916279918, -25.5421207251282, -24.5765618316355, \
                      -23.6253773632229, -22.6905837852008, -21.7739171102008, \
                      -20.876803194518, -20.0003333413145, -19.14524562812, -18.31191227812, \
                      -17.5003332913145, -16.710136444518, -15.9405836602008, \
                      -15.1905836352008, -14.4587105132229, -13.7432282816355, \
                      -13.0421204751282, -12.3531246779918, -11.673771234679, \
                      -11.0014255062951, -10.33333295, -9.66666625, -9.00205149364453,\
                      -8.34354204256012, -7.69504092549518, -7.06020473279879, \
                      -6.4423535790308, -5.84438935072255, -5.26872425229961, \
                      -4.71722140960322, -4.1911489935487, -3.6911489935487, -3.21722140960322,\
                      -2.76872425229961, -2.34438935072255, -1.9423535790308, \
                      -1.56020473279879, -1.19504092549518, -0.843542042560123, \
                      -0.502051493644533, -0.16666625, 0.16666705, 0.502052293644532,\
                      0.843542842560123, 1.19504172549518, 1.56020553279879, 1.9423543790308,\
                      2.34439015072255, 2.76872505229961, 3.21722220960322, 3.6911497935487,\
                      4.1911497935487, 4.71722220960322, 5.26872505229961, 5.84439015072255, \
                      6.4423543790308, 7.06020553279879, 7.69504172549518, 8.34354284256012, \
                      9.00205229364453, 9.66666705, 10.33333375, 11.0014263062951, \
                      11.673772034679, 12.3531254779918, 13.0421212751282, 13.7432290816355,\
                      14.4587113132229, 15.1905844352008, 15.9405844602008, 16.710137244518, \
                      17.5003340913145, 18.31191307812, 19.14524642812, 20.0003341413145, \
                      20.876803994518, 21.7739179102008, 22.6905845852008, 23.6253781632229, \
                      24.5765626316355, 25.5421215251282, 26.5197924279918, 27.507105684679, \
                      28.5014266562951, 29.5, 30.5, 31.5, 32.5, 33.5, 34.5, 35.5, 36.5, 37.5, \
                      38.5, 39.5, 40.5, 41.5, 42.5, 43.5, 44.5, 45.5, 46.5, 47.5, 48.5, 49.5, \
                      50.5, 51.5, 52.5, 53.5, 54.5, 55.5, 56.5, 57.5, 58.5, 59.5, 60.5, 61.5, \
                      62.5, 63.5, 64.5, 65.5, 66.5, 67.5, 68.5, 69.5, 70.5, 71.5, 72.5, 73.5, \
                      74.5, 75.5, 76.5, 77.5, 78.5, 79.5, 80.5, 81.5, 82.5, 83.5, 84.5, 85.5, \
                      86.5, 87.5, 88.5, 89.5))
        lev=sp.array((5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 105, 115, 125, 135, 145, 155, \
                      165, 175, 185, 195, 205, 215, 225, 236.122817993164, 250.599975585938,\
                      270.620819091797, 298.304931640625, 335.675628662109, 384.63427734375, \
                      446.936645507812, 524.170593261719, 617.736328125, 728.828491210938, \
                      858.421508789062, 1007.25708007812, 1175.83483886719, 1364.40625, \
                      1572.97131347656, 1801.27868652344, 2048.82861328125, 2314.87915039062, \
                      2598.45629882812, 2898.365234375, 3213.20581054688, 3541.38989257812, \
                      3881.162109375, 4230.62060546875, 4587.74267578125, 4950.40869140625, \
                      5316.4287109375))
        self.grid=utl.Grid(lon,lat,lev)

        self.vlist=[('vo',sp.float32,self.grid.dims)]

        r=rrule.rrule(rrule.YEARLY,dtstart=datetime.date(2000,1,1),count=500)
        self.time=sp.array(r[:],dtype='|O')
        
    def fromfile(self,varname,iind=slice(None),\
                 jind=slice(None),kind=slice(None),tind=slice(None)):
        
        ii,jj,kk,tt=utl.scalar2slice(iind,jind,kind,tind)
        var=self.subset(ii,jj,kk,tt)
        var.name=varname

        a=sp.memmap(self.flist[0],dtype=self.vlist)
        var.data=sp.ma.masked_values(a[tt][varname][:,kk][:,:,jj][:,:,:,ii],self.undef)
                    
        return var

ctl=Ctl()
