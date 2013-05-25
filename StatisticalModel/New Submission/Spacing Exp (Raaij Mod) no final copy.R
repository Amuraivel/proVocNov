# program to minimise experiment of rumelhart 
# experiment with paired associations 
# letter combination with a digit
# after recognition strengthening added to the trace.
# after buffer no strengthening  
# sam * probability of sampling 
# rec * probability ofrecovery 
# rec * probability ofrecall 
#, however, buffer 
# strengthening b with 1,2,3,4, or 5
conds <<- 9
ifflag <<- 0

recog <<- function (x) {1}

fluctpa <<- function (xpars){

daypar <<- 10000*xpars[7]
if (daypar>33600) daypar <<- 33600
  if (ifflag==0) {
    naq <<- array(0,c(9,5)) 
    obs <<- array(0,c(9,5)) 
    p <<- array(0,c(9,8)) 
    errobs <<- array(0,c(9,5)) 
    nc1 <<- array(0,c(10)) 
    nc2 <<- array(0,c(10)) 
    nd1 <<- array(0,c(14)) 
    nd2 <<- array(0,c(14)) 
    nd3 <<- array(0,c(14)) 
    buf <<- array(0,c(9)) 
    ne1 <<- array(0,c(15)) 
    ne2 <<- array(0,c(15)) 
    ne3 <<- array(0,c(15)) 
    ne4 <<- array(0,c(15)) 
    t1 <<- array(0,c(9)) 
    t2 <<- array(0,c(9,5)) 
    r1 <<- array(0,c(4)) 
    ak1 <<- array(0,c(4)) 
    a1 <<- array(0,c(4)) 
    p1 <<- array(0,c(9)) 
    p2 <<- array(0,c(9)) 
    p3 <<- array(0,c(9)) 
    p4 <<- array(0,c(9)) 
    p5 <<- array(0,c(9)) 
    r2 <<- array(0,c(4,4)) 
    ak2 <<- array(0,c(4,4)) 
    a2 <<- array(0,c(4,4)) 
    r12 <<- array(0,c(4,4)) 
    ak12 <<- array(0,c(4,4)) 
    a12 <<- array(0,c(4,4)) 
    r3 <<- array(0,c(4,4,4)) 
    ak3 <<- array(0,c(4,4,4)) 
    a3 <<- array(0,c(4,4,4)) 
    r23 <<- array(0,c(4,4,4)) 
    ak23 <<- array(0,c(4,4,4)) 
    a23 <<- array(0,c(4,4,4)) 
    r123 <<- array(0,c(4,4,4)) 
    ak123 <<- array(0,c(4,4,4)) 
    a123 <<- array(0,c(4,4,4)) 
    r4 <<- array(0,c(4,4,4,4)) 
    ak4 <<- array(0,c(4,4,4,4)) 
    a4 <<- array(0,c(4,4,4,4)) 
    r34 <<- array(0,c(4,4,4,4)) 
    ak34 <<- array(0,c(4,4,4,4)) 
    a34 <<- array(0,c(4,4,4,4)) 
    r234 <<- array(0,c(4,4,4,4)) 
    ak234 <<- array(0,c(4,4,4,4)) 
    a234 <<- array(0,c(4,4,4,4)) 
    r1234 <<- array(0,c(4,4,4,4)) 
    ak1234 <<- array(0,c(4,4,4,4)) 
    a1234 <<- array(0,c(4,4,4,4)) 
    r5 <<- array(0,c(4,4,4,4,4)) 
    r45 <<- array(0,c(4,4,4,4,4)) 
    r345 <<- array(0,c(4,4,4,4,4)) 
    r2345 <<- array(0,c(4,4,4,4,4)) 
    r12345 <<- array(0,c(4,4,4,4,4))
 

    # --- reads in indexes m and n --- 
    # --- reads in times t --- 
    # --- reads in observed data obs --- 

    x <<- read.table("~/Downloads/model-and-seq/New Submission/data P&A no final.dat",nrows=45)
        for (m in 1:9) {
            for (n in 1:5) {
                naq[m,n] <<- x[m*5-5+n,1]
                t2[m,n] <<- x[m*5-5+n,2]
                if (t2[m,n]==600) t2[m,n]<<-daypar
                errobs[m,n] <<- x[m*5-5+n,3]  
                obs[m,n] <<- errobs[m,n]
            }
         }
                
    
    #     --- reads in indexes for arrays containing previous trials contributions to a ---
    
    x <<- read.table("~/Downloads/model-and-seq/New Submission/data P&A no final.dat",skip=45, nrows=4)
    
        for (i in 1:4) {
            t1[i] <<- x[i,1]
            if (t1[i]==600) t1[i]<<-daypar
            }
    
    x <<- read.table("~/Downloads/model-and-seq/New Submission/data P&A no final.dat",skip=49, nrows=10)
        for (i in 1:10) {
            nc1[i]<<- x[i,1]
            nc2[i]<<- x[i,2]
        }
    
    x <<- read.table("~/Downloads/model-and-seq/New Submission/data P&A no final.dat",skip=59, nrows=14)
        for (i in 1:14) {
            nd1[i]<<- x[i,1]
            nd2[i]<<- x[i,2]
            nd3[i]<<- x[i,3]
        }
    
    x <<- read.table("~/Downloads/model-and-seq/New Submission/data P&A no final.dat",skip=73, nrows=15)
        for (i in 1:15) {
            ne1[i]<<- x[i,1]
            ne2[i]<<- x[i,2]
            ne3[i]<<- x[i,3]
            ne4[i]<<- x[i,4]
            }
            
    ifflag <<- 0
}

 
    al <<- xpars[1] 
    if (a1<0) a1<<-.000000001
    s <<- xpars[2] 
    if (s<0)  s <<- .000000001
    if (s>.8) s <<- .45
    xlam <<-  xpars[3]
    if (xlam<0)  xlam <<- .2
    if (xlam>.8) xlam <<- .7
    b <<- xpars[4]
    if (b<0) b <<- 0
    if (b>15.5) b <<- 1
    bi <<- xpars[4]
    if (bi<0) bi <<- 0
    if (bi>15.5) bi <<- 1
    w <<- xpars[6]
   


      xincr <<- b
      if (bi>0.01) xincr <<- bi
      chi <<- 0.0
      ss <<- 0.0
      b1 <<- (b)
      b2 <<- (b+xincr)
      b3 <<- (b+2.0*xincr)
      b4 <<- (b+3.0*xincr)
      b5 <<- ( b+4.0*xincr)
      ak0 <<- 1.0
      a0 <<- 1.0
     
      z2 <<- 0
      z <<- 3
      if (z<1) z <<- 1
      a <<- 5
      xlmax <<- 3
      theta <<- .5
      if (theta>1) theta <<- .5


#     --- after a presentation ---
      for (i in 1:4) {
        ov <<- a0*exp(-al*t1[i])+ak0*s*(1.0-exp(-al*t1[i]))
        sam <<- (ov*a*b1)/(ov*a*b1+z+t1[i]*z2)
        rec <<- 1.0-exp(-theta*(ov*a+b1))
        r1[i] <<- (1.0-(1.0-sam)**xlmax)*rec
        ak1[i] <<- ak0+(1.0-ov)
        a1[i] <<- 1.0

#     --- the buffer ---
        buf[i] <<- exp(-xlam*t1[i])}

#     --- after two presentations ---
      for (i in 1:10) {
        i1 <<- nc1[i]
        i2 <<- nc2[i]
      l2 <<- t1[i2]
      ov <<- a1[i1]*exp(-al*l2)+ak1[i1]*s*(1.0-exp(-al*l2))
      sam <<- (ov*a*b2)/(ov*a*b2+z+l2*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b2))
      r12[i1,i2] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak12[i1,i2] <<- ak1[i1]+(1.0-ov)
      a12[i1,i2] <<- 1.0

      l2 <<- t1[i1]+t1[i2]+1.0
      ov <<- a0*exp(-al*l2)+ak0*s*(1.0-exp(-al*l2))
      sam <<- (ov*a*b1)/(ov*a*b1+z+l2*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b1))
      r2[i1,i2] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak2[i1,i2] <<- ak0+(1.0-ov)
      a2[i1,i2] <<- 1.0}

#     --- after three presentations ---
      for (i in 1:14) {
        i1 <<- nd1[i]
        i2 <<- nd2[i]
        i3 <<- nd3[i]
      l3 <<- t1[i3]
      ov <<- a12[i1,i2]*exp(-al*l3)
      ov <<- ov+ak12[i1,i2]*s*(1.0-exp(-al*l3))
      sam <<- (ov*a*b3)/(ov*a*b3+z+l3*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b3))
      r123[i1,i2,i3] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak123[i1,i2,i3] <<- ak12[i1,i2]+(1.0-ov)
      a123[i1,i2,i3] <<- 1.0

      l3 <<- t1[i3]
      ov <<- a2[i1,i2]*exp(-al*l3)
      ov <<- ov+ak2[i1,i2]*s*(1.0-exp(-al*l3))
      sam <<- (ov*a*b2)/(ov*a*b2+z+l3*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b2))
      r23[i1,i2,i3] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak23[i1,i2,i3] <<- ak2[i1,i2]+(1.0-ov)
      a23[i1,i2,i3] <<- 1.0

      l3 <<- t1[i1]+t1[i2]+t1[i3]+2.0
      ov <<- a0*exp(-al*l3)
      ov <<- ov+ak0*s*(1.0-exp(-al*l3))
      sam <<- (ov*a*b1)/(ov*a*b1+z+l3*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b1))
      r3[i1,i2,i3] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak3[i1,i2,i3] <<- ak0+(1.0-ov)
      a3[i1,i2,i3] <<- 1.0}

#     --- after four presentations ---
      for (i in 1:15) {
        i1 <<- ne1[i]
        i2 <<- ne2[i]
        i3 <<- ne3[i]
        i4 <<- ne4[i]
      l4 <<- t1[i4]
      ov <<- a123[i1,i2,i3]*exp(-al*l4)
      ov <<- ov+ak123[i1,i2,i3]*s*(1.0-exp(-al*l4))
      sam <<- (ov*a*b4)/(ov*a*b4+z+l4*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b4))
      r1234[i1,i2,i3,i4] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak1234[i1,i2,i3,i4] <<- ak123[i1,i2,i3]+(1.0-ov)
      a1234[i1,i2,i3,i4] <<- 1.0

      l4 <<- t1[i4]
      ov <<- a23[i1,i2,i3]*exp(-al*l4)
      ov <<- ov+ak23[i1,i2,i3]*s*(1.0-exp(-al*l4))
      sam <<- (ov*a*b3)/(ov*a*b3+z+l4*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b3))
      r234[i1,i2,i3,i4] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak234[i1,i2,i3,i4] <<- ak23[i1,i2,i3]+(1.0-ov)
      a234[i1,i2,i3,i4] <<- 1.0

      l4 <<- t1[i4]
      ov <<- a3[i1,i2,i3]*exp(-al*l4)
      ov <<- ov+ak3[i1,i2,i3]*s*(1.0-exp(-al*l4))
      sam <<- (ov*a*b2)/(ov*a*b2+z+l4*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b2))
      r34[i1,i2,i3,i4] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak34[i1,i2,i3,i4] <<- ak3[i1,i2,i3]+(1.0-ov)
      a34[i1,i2,i3,i4] <<- 1.0

      l4 <<- t1[i1]+t1[i2]+t1[i3]+t1[i4]+3.0
      ov <<- a0*exp(-al*l4)
      ov <<- ov+ak0*s*(1.0-exp(-al*l4))
      sam <<- (ov*a*b1)/(ov*a*b1+z+l4*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b1))
      r4[i1,i2,i3,i4] <<- (1.0-(1.0-sam)**xlmax)*rec
      ak4[i1,i2,i3,i4] <<- ak0+(1.0-ov)
      a4[i1,i2,i3,i4] <<- 1.0 }


#     --- after five presentations [therefore all presentations] ---
      for (i in 1:conds) {
        i1 <<- naq[i,1]
        i2 <<- naq[i,2]
        i3 <<- naq[i,3]
        i4 <<- naq[i,4]
        i5 <<- naq[i,5]
        t5 <<- daypar
      ov <<- a1234[i1,i2,i3,i4]*exp(-al*t5)
      ov <<- ov+ak1234[i1,i2,i3,i4]*s*(1.0-exp(-al*t5))
      sam <<- (ov*a*b5)/(ov*a*b5+z+t5*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b5))
      r12345[i1,i2,i3,i4,i5] <<- (1.0-(1.0-sam)**xlmax)*rec

      ov <<- a234[i1,i2,i3,i4]*exp(-al*t5)
      ov <<- ov+ak234[i1,i2,i3,i4]*s*(1.0-exp(-al*t5))
      sam <<- (ov*a*b4)/(ov*a*b4+z+t5*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b4))
      r2345[i1,i2,i3,i4,i5] <<- (1.0-(1.0-sam)**xlmax)*rec

      ov <<- a34[i1,i2,i3,i4]*exp(-al*t5)
      ov <<- ov+ak34[i1,i2,i3,i4]*s*(1.0-exp(-al*t5))
      sam <<- (ov*a*b3)/(ov*a*b3+z+t5*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b3))
      r345[i1,i2,i3,i4,i5] <<- (1.0-(1.0-sam)**xlmax)*rec

      ov <<- a4[i1,i2,i3,i4]*exp(-al*t5)
      ov <<- ov+ak4[i1,i2,i3,i4]*s*(1.0-exp(-al*t5))
      sam <<- (ov*a*b2)/(ov*a*b2+z+t5*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b2))
      r45[i1,i2,i3,i4,i5] <<- (1.0-(1.0-sam)**xlmax)*rec

      l5 <<- t1[i1]+t1[i2]+t1[i3]+t1[i4]+t1[i5]+4.0
      ov <<- a0*exp(-al*l5)
      ov <<- ov+ak0*s*(1.0-exp(-al*l5))
      sam <<- (ov*a*b1)/(ov*a*b1+z+l5*z2)
      rec <<- 1.0-exp(-theta*(ov*a+b1))
      r5[i1,i2,i3,i4,i5] <<- (1.0-(1.0-sam)**xlmax)*rec}


chi <<- 0
ss <<- 0
sqr <<- 0

      for (m in 1:conds) {
        n1 <<- naq[m,1]
        n2 <<- naq[m,2]
        n3 <<- naq[m,3]
        n4 <<- naq[m,4]
        n5 <<- naq[m,5]


        s1 <<- buf[n1]
        s2 <<- buf[n2]
        s3 <<- buf[n3]
        s4 <<- buf[n4]
        s5 <<- buf[n5]

#     --- a presentation ---

        x1 <<- w*s1
        x2 <<- w*(1-s1)*r1[n1]
        p1[m] <<- x1+x2
        p[m,1] <<- p1[m]

x2b <<- w*(1-s1)*recog(r1[n1])
p1b <<- x1 + x2b
        
#     --- two presentations ---
        x11 <<- x1*s2
        x12 <<- x1*(1-s2)*r2[n1,n2]
        x2 <<- x2b*r12[n1,n2]
        x3 <<- (1-p1b)*w*s2
        x4 <<- (1-p1b)*w*(1-s2)*r1[n2]
        p2[m] <<- x11+x12+x2+x3+x4
        p[m,2] <<- p2[m]

x12b <<- x1*(1-s2)*recog(r2[n1,n2])
x2b <<- x2b*recog(r12[n1,n2])
x4b <<- (1-p1b)*w*(1-s2)*recog(r1[n2])
p2b <<- x11+x12b+x2b+x3+x4b

#     --- three presentations ---

        x111 <<- x11*s3
        x112 <<- x11*(1-s3)*r3[n1,n2,n3]
        x12 <<- x12b*r23[n1,n2,n3]
        x2 <<- x2b*r123[n1,n2,n3]
        x31 <<- x3*s3
        x32 <<- x3*(1-s3)*r2[n2,n3]
        x4 <<- x4b*r12[n2,n3]
        x5 <<- (1-p2b)*w*s3
        x6 <<- (1-p2b)*w*(1-s3)*r1[n3]
        p3[m] <<- x111+x112+x12+x2+x31+x32+x4+x5+x6
        p[m,3] <<- p3[m]
        
x112b <<- x11*(1-s3)*recog(r3[n1,n2,n3])
x12b <<- x12b*recog(r23[n1,n2,n3])
x2b <<- x2b*recog(r123[n1,n2,n3])
x32b <<- x3*(1-s3)*recog(r2[n2,n3])
x4b <<- x4b*recog(r12[n2,n3])
x6b <<- (1-p2b)*w*(1-s3)*recog(r1[n3])
p3b <<- x111+x112b+x12b+x2b+x31+x32b+x4b+x5+x6b

#     --- four presentations ---

        x1111 <<- x111*s4
        x1112 <<- x111*(1-s4)*r4[n1,n2,n3,n4]
        x112 <<- x112b*r34[n1,n2,n3,n4]
        x12 <<- x12b*r234[n1,n2,n3,n4]
        x2 <<- x2b*r1234[n1,n2,n3,n4]
        x311 <<- x31*s4
        x312 <<- x31*(1-s4)*r3[n2,n3,n4]
        x32 <<- x32b*r23[n2,n3,n4]
        x4 <<- x4b*r123[n2,n3,n4]
        x51 <<- x5*s4
        x52 <<- x5*(1-s4)*r2[n3,n4]
        x6 <<- x6b*r12[n3,n4]
        x7 <<- (1-p3b)*w*s4
        x8 <<- (1-p3b)*w*(1-s4)*r1[n4]
        p4[m] <<- x1111+x1112+x112+x12+x2+x311+x312+x32+x4+x51+x52
        p4[m] <<- p4[m]+x6+x7+x8
        p[m,4] <<- p4[m]

x1112b <<- x111*(1-s4)*recog(r4[n1,n2,n3,n4])
x112b <<- x112b*recog(r34[n1,n2,n3,n4])
x12b <<- x12b*recog(r234[n1,n2,n3,n4])
x2b <<- x2b*recog(r1234[n1,n2,n3,n4])
x312b <<- x31*(1-s4)*recog(r3[n2,n3,n4])
x32b <<- x32b*recog(r23[n2,n3,n4])
x4b <<- x4b*recog(r123[n2,n3,n4])
x52b <<- x5*(1-s4)*recog(r2[n3,n4])
x6b <<- x6b*recog(r12[n3,n4])
x8b <<- (1-p3b)*w*(1-s4)*recog(r1[n4])
p4b <<- x1111+x1112b+x112b+x12b+x2b+x311+x312b+x32b+x4b+x51+x52b+x6b+x7+x8b
        
#     --- five presentations ---

        x11111 <<- x1111*s5
        x11112 <<- x1111*(1-s5)*r5[n1,n2,n3,n4,n5]
        x1112 <<- x1112b*r45[n1,n2,n3,n4,n5]
        x112 <<- x112b*r345[n1,n2,n3,n4,n5]
        x12 <<- x12b*r2345[n1,n2,n3,n4,n5]
        x2 <<- x2b*r12345[n1,n2,n3,n4,n5]
        x3111 <<- x311*s5
        x3112 <<- x311*(1-s5)*r4[n2,n3,n4,n5]
        x312 <<- x312b*r34[n2,n3,n4,n5]
        x32 <<- x32b*r234[n2,n3,n4,n5]
        x4 <<- x4b*r1234[n2,n3,n4,n5]
        x511 <<- x51*s5
        x512 <<- x51*(1-s5)*r3[n3,n4,n5]
        x52 <<- x52b*r23[n3,n4,n5]
        x6 <<- x6b*r123[n3,n4,n5]
        x71 <<- x7*s5
        x72 <<- x7*(1-s5)*r2[n4,n5]
        x8 <<- x8b*r12[n4,n5]
        x9 <<- (1-p4b)*w*s5
        x10 <<- (1-p4b)*w*(1-s5)*r1[n5]
        p5[m] <<- x11111+x11112+x1112+x112+x12+x2+x311+x312+x32+x4+x511
        p5[m] <<- p5[m]+x512+x52+x6+x71+x72+x8+x9+x10
        p[m,5] <<- p5[m]

        for (i in 1:5) {
        
        
        if(obs[m,i]>0){
        if(is.nan(p[m,i])) p[m,i]<<-0
        if(p[m,i]>1) p[m,i]<<-1
        if(p[m,i]<0) p[m,i]<<-0
        
          sqr <<- 320*(p[m,i]-obs[m,i])**2/(p[m,i]-p[m,i]^2)
         # ss <<- ss+(p[m,i]-obs[m,i])**2
          chi <<- chi+sqr}}
          
}
                                              


chi
}
 
basepars <<- c(0.02400829, 0.11912809, 0.14102034, 0.55672372, 0.94038865, 0.65475755, 0.19709154)



#  --- Optimize model from base set of parameters ---
time1 <<- Sys.time()
vecparm <<- optim(basepars,fluctpa,method=c("Nelder-Mead"),control=list(REPORT=1,trace=1,maxit=1000))
#fluctpa(basepars)
print(Sys.time()-time1)
print(vecparm)

#  --- Use found parameters to show final graphs ---
fluctpa(vecparm$par)
par(mfrow=c(3,3),main="Raiij Fit")
for (i in 1:9) {
matplot(p[i,c(obs[i,]>-1,F,F,F)],ylim=c(0,1),col=1,lty=1,type="b",xaxt="n",lwd=3,xlab="trial",ylab="probability correct",main=paste("Cond ",i),pch=19,width=10,height=8)
matlines(obs[i,obs[i,]>-1],col=2,type="b",lwd=3,lty=2,pch=19)} 
