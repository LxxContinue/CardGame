//
//  wshFile.c
//  CardGame
//
//  Created by LXX on 2019/10/9.
//  Copyright © 2019年 LXX. All rights reserved.
//

#include "wshFile.h"

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>

char qiandun[6]={},zhongdun[10]={},houdun[10]={};//duniŒ™1,2,3∑÷±¥˙±Ì«∞÷–∫Û∂◊
char qiandunf[3]={},zhongdunf[5]={},houdunf[5]={};
int qiandunp[3]={0},zhongdunp[5]={0},houdunp[5]={0};

char pai[60]={};// ‰»Î≈∆

int shunxup[13]={0},count[15]={0},flower[4]={0};
//shunxup∞—≈∆¥”–°µΩ¥Û≈≈–Ú°£countº«¬º√ø’≈“ª—˘¥Ûµƒ≈∆µƒ ˝¡ø∆‰£¨∆‰÷–AÀ„◊˜14°£flowerº«¬ºÀƒ∏ˆª®…´µƒ≈∆µƒ ˝¡ø
char shunxuf[13]={};//∂‘”¶¥”–°µΩ¥Û≈∆µƒ∑˚∫≈


int thss=0,ths[5];//thssÕ¨ª®À≥µƒ ˝¡ø,ths∑≈Õ¨ª®À≥µƒ≈∆
char thsf[5]; //thsf∑≈Õ¨ª®À≥µƒ∑˚∫≈
int se0=-1,se1=-1,se2=-1,se3=-1;//Àƒ∏ˆª®…´µƒÕ¨ª®À≥¿Ô◊Ó¥Ûµƒ≈∆£¨√ª”–µƒª∞æÕ «-1
char ose0[13]={},ose1[13]={},ose2[13],ose3[13];//¥Ê∑≈ª®…´µƒ≈∆
int ose0i=0,ose1i=0,ose2i=0,ose3i=0;//Àƒ∏ˆª®…´≈∆µƒ ˝¡ø


int zhas=0,zham=-1,zhad=-1,zha[5];//’®µØµƒ ˝¡ø£¨’®µØµƒ≈∆¥Û–°£¨’®µØ¥¯µƒ≈∆¥Û–°
char zhaf[5];//’®µØŒÂ’≈≈∆µƒ∑˚∫≈

int hulus=0,hulu[5];//∫˘¬´
char huluf[5];

int tonghuas=0,tonghua[5];//Õ¨ª®
char tonghuaf[5];

int shuns=0,shun[5];//À≥◊”
char shunf[5];

int santiaos=0,santiao[5];//»˝Ãı
char santiaof[5];

int liangduis=0,liangdui[5];//¡Ω∂‘
char liangduif[5];

int yiduis=0,yidui[5];//“ª∂‘
char yiduif[5];

int yizhangs=0,yizhang[5];//“ª’≈
char yizhangf[5];


char qiandung[60]={};
int qiandungi=0;
char jieguo[60]={};




int ifths()//≈–∂œ «∑Ò”–Õ¨ª®À≥
{
    for(int i=0;i<4;i++)
    {
        if(flower[i]>=5)//»Áπ˚”–Õ¨ª®
        {
            if(i==0)//#…´
            {
                for(int j=0;j<13;j++)
                {
                    if(shunxuf[j]=='#')
                    {
                        ose0[ose0i]=shunxup[j];
                        ose0i++;
                    }
                }
                for(int j=0;j<ose0i-4;j++)
                {
                    if(ose0[ose0i-j-1]+ose0[ose0i-j-5]==2*ose0[ose0i-j-3]&&ose0[ose0i-j-1]==ose0[ose0i-j-2]+1)//»Áπ˚µ»±»≤¢«“µ»≤ÓæÕ «Õ¨ª®À≥
                    {
                        se0=ose0[ose0i-j-1];
                        thss=1;
                        break;
                    }
                }
            }
            
            if(i==1)//$…´
            {
                for(int j=0;j<13;j++)
                {
                    if(shunxuf[j]=='$')
                    {
                        ose1[ose1i]=shunxup[j];
                        ose1i++;
                    }
                }
                for(int j=0;j<ose1i-4;j++)
                {
                    if(ose1[ose1i-j-1]+ose1[ose1i-j-5]==2*ose1[ose1i-j-3]&&ose1[ose1i-j-1]==ose1[ose1i-j-2]+1)
                    {
                        se1=ose1[ose1i-j-1];
                        thss=1;
                        break;
                    }
                }
            }
            
            if(i==2)//&…´
            {
                for(int j=0;j<13;j++)
                {
                    if(shunxuf[j]=='&')
                    {
                        ose2[ose2i]=shunxup[j];
                        ose2i++;
                    }
                }
                for(int j=0;j<ose2i-4;j++)
                {
                    if(ose2[ose2i-j-1]+ose2[ose2i-j-5]==2*ose2[ose2i-j-3]&&ose2[ose2i-j-1]==ose2[ose2i-j-2]+1)
                    {
                        se2=ose2[ose2i-j-1];
                        thss=1;
                        break;
                    }
                }
            }
            
            if(i==3)//*…´
            {
                for(int j=0;j<13;j++)
                {
                    if(shunxuf[j]=='*')
                    {
                        ose3[ose3i]=shunxup[j];
                        ose3i++;
                    }
                }
                for(int j=0;j<ose3i-4;j++)
                {
                    if(ose3[ose3i-j-1]+ose3[ose3i-j-5]==2*ose3[ose3i-j-3]&&ose3[ose3i-j-1]==ose3[ose3i-j-2]+1)
                    {
                        se3=ose3[ose3i-j-1];
                        thss=1;
                        break;
                    }
                }
            }
        }
    }
    return thss;
}

void printths(int duni)//»∑∂®”–Õ¨ª®À≥÷Æ∫Ûµƒ≤Ÿ◊˜
{
    if(se0>se1&&se0>se2&&se0>se3)
    {
        for(int i=0;i<5;i++)
        {
            ths[4-i]=ose0[ose0i-i-1];
            thsf[i]='#';
        }
    }
    
    if(se1>se0&&se1>se2&&se1>se3)
    {
        for(int i=0;i<5;i++)
        {
            ths[4-i]=ose1[ose1i-i-1];
            thsf[i]='$';
        }
    }
    
    if(se2>se1&&se2>se0&&se2>se3)
    {
        for(int i=0;i<5;i++)
        {
            ths[4-i]=ose2[ose2i-i-1];
            thsf[i]='&';
        }
    }
    
    if(se3>se1&&se3>se2&&se3>se0)
    {
        for(int i=0;i<5;i++)
        {
            ths[4-i]=ose3[ose3i-i-1];
            thsf[i]='*';
        }
    }
    
    
    //printf("Õ¨ª®À≥£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",thsf[i],ths[i]);
        if(duni==3)
        {
            houdunf[i]=thsf[i];
            houdunp[i]=ths[i];
            
            houdun[dunii]=thsf[i];
            dunii++;
            if(ths[i]<=9)
            {
                houdun[dunii]=ths[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(ths[i]/10)+'0';
                dunii++;
                houdun[dunii]=(ths[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=thsf[i];
            zhongdunp[i]=ths[i];
            
            zhongdun[dunii]=thsf[i];
            dunii++;
            if(ths[i]<=9)
            {
                zhongdun[dunii]=ths[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(ths[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(ths[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
}

int ifzhad()//≈–∂œ «∑Ò”–’®µØ
{
    for(int i=14;i>1;i--)
    {
        if(count[i]==4)
        {
            zhas=1;
            zham=i;
            break;
        }
    }
    return zhas;
}


void printzhad(int duni)//”–’®µØ÷Æ∫Ûµƒ≤Ÿ◊˜
{
    zhaf[0]='#';
    zhaf[1]='$';
    zhaf[2]='&';
    zhaf[3]='*';
    zha[0]=zham;
    zha[1]=zham;
    zha[2]=zham;
    zha[3]=zham;
    for(int i=2;i<15;i++)
    {
        if(count[i]==1)
        {
            zhad=i;
            break;
        }
    }
    if(zhad==-1)
    {
        for(int i=2;i<15;i++)
        {
            if(count[i]==2)
            {
                zhad=i;
                break;
            }
        }
    }
    if(zhad==-1)
    {
        for(int i=2;i<15;i++)
        {
            if(count[i]==3)
            {
                zhad=i;
                break;
            }
        }
    }
    if(zhad==-1)
    {
        for(int i=2;i<15;i++)
        {
            if(i!=zham&&count[i]>0)
            {
                zhad=i;
                break;
            }
        }
    }
    
    for(int i=0;i<13;i++)
    {
        if(shunxup[i]==zhad)
        {
            zhaf[4]=shunxuf[i];
            zha[4]=zhad;
            break;
        }
    }
    //printf("’®µØ£∫");
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",zhaf[i],zha[i]);
        int dunii=0;
        if(duni==3)
        {
            houdunf[i]=zhaf[i];
            houdunp[i]=zha[i];
            
            houdun[dunii]=zhaf[i];
            dunii++;
            if(zha[i]<=9)
            {
                houdun[dunii]=zha[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(zha[i]/10)+'0';
                dunii++;
                houdun[dunii]=(zha[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=zhaf[i];
            zhongdunp[i]=zha[i];
            
            zhongdun[dunii]=zhaf[i];
            dunii++;
            if(zha[i]<=9)
            {
                zhongdun[dunii]=zha[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(zha[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(zha[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
    //printf("weiz");
}


int ifhulu()//≈–∂œ «∑Ò”–∫˘¬´
{
    for(int i=14;i>1;i--)
    {
        if(count[i]==3)
        {
            for(int j=2;j<15;j++)
            {
                if(count[j]==2)
                {
                    //printf("%d %d\n",i,j);
                    hulus=1;
                    hulu[0]=i;
                    hulu[1]=i;
                    hulu[2]=i;
                    hulu[3]=j;
                    hulu[4]=j;
                    int hulufi=0;
                    for(int k=0;k<13;k++)
                    {
                        if(shunxup[k]==hulu[0])
                        {
                            huluf[hulufi]=shunxuf[k];
                            hulufi++;
                        }
                    }
                    for(int k=0;k<13;k++)
                    {
                        if(shunxup[k]==hulu[4])
                        {
                            huluf[hulufi]=shunxuf[k];
                            hulufi++;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    return hulus;
}
void printhulu(int duni)//”–∫˘¬´÷Æ∫Ûµƒ≤Ÿ◊˜
{
    //printf("∫˘¬´£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",huluf[i],hulu[i]);
        if(duni==3)
        {
            houdunf[i]=huluf[i];
            houdunp[i]=hulu[i];
            
            houdun[dunii]=huluf[i];
            dunii++;
            if(hulu[i]<=9)
            {
                houdun[dunii]=hulu[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(hulu[i]/10)+'0';
                dunii++;
                houdun[dunii]=(hulu[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=huluf[i];
            zhongdunp[i]=hulu[i];
            
            zhongdun[dunii]=huluf[i];
            dunii++;
            if(hulu[i]<=9)
            {
                zhongdun[dunii]=hulu[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(hulu[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(hulu[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
}


int iftonghua()
{
    for(int i=0;i<4;i++)
    {
        if(flower[i]>=5)//»Áπ˚”–Õ¨ª®
        {
            tonghuas=1;
            for(int j=12;j>=0;j--)
            {
                if(shunxuf[j]=='#')
                {
                    if(flower[0]>=5)
                    {
                        int tonghuai=0;
                        for(int k=0;k<5;k++)
                        {
                            tonghua[4-tonghuai]=ose0[ose0i-k-1];
                            tonghuaf[4-tonghuai]='#';
                            tonghuai++;
                        }
                        break;
                    }
                }
                
                if(shunxuf[j]=='$')
                {
                    if(flower[1]>=5)
                    {
                        int tonghuai=0;
                        for(int k=0;k<5;k++)
                        {
                            tonghua[4-tonghuai]=ose1[ose1i-k-1];
                            tonghuaf[4-tonghuai]='$';
                            tonghuai++;
                        }
                        break;
                    }
                }
                
                if(shunxuf[j]=='&')
                {
                    if(flower[2]>=5)
                    {
                        int tonghuai=0;
                        for(int k=0;k<5;k++)
                        {
                            tonghua[4-tonghuai]=ose2[ose2i-k-1];
                            tonghuaf[4-tonghuai]='&';
                            tonghuai++;
                        }
                        break;
                    }
                }
                
                if(shunxuf[j]=='*')
                {
                    if(flower[3]>=5)
                    {
                        int tonghuai=0;
                        for(int k=0;k<5;k++)
                        {
                            tonghua[4-tonghuai]=ose3[ose3i-k-1];
                            tonghuaf[4-tonghuai]='*';
                            tonghuai++;
                        }
                        break;
                    }
                }
            }
            
            
            break;
        }
    }
    return tonghuas;
}
void printtonghua(int duni)//”–Õ¨ª®µƒ«Èøˆ
{
    //printf("Õ¨ª®£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",tonghuaf[i],tonghua[i]);
        if(duni==3)
        {
            houdunf[i]=tonghuaf[i];
            houdunp[i]=tonghua[i];
            
            houdun[dunii]=tonghuaf[i];
            dunii++;
            if(tonghua[i]<=9)
            {
                houdun[dunii]=tonghua[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(tonghua[i]/10)+'0';
                dunii++;
                houdun[dunii]=(tonghua[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=tonghuaf[i];
            zhongdunp[i]=tonghua[i];
            
            zhongdun[dunii]=tonghuaf[i];
            dunii++;
            if(tonghua[i]<=9)
            {
                zhongdun[dunii]=tonghua[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(tonghua[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(tonghua[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
}

int ifshunzi()//≈–∂œ «∑Ò”–À≥◊”
{
    for(int i=14;i>1;i--)
    {
        if(count[i]>0&&count[i-1]>0&&count[i-2]>0&&count[i-3]>0&&count[i-4]>0)//”–À≥◊”
        {
            shuns=1;
            shun[4]=i;
            shun[3]=i-1;
            shun[2]=i-2;
            shun[1]=i-3;
            shun[0]=i-4;
            int shunfi=0;
            for(int j=0;j<13;j++)
            {
                if(shunxup[j]==i-4+shunfi)
                {
                    shunf[shunfi]=shunxuf[j];
                    shunfi++;
                    if(shunfi==5)
                        break;
                }
            }
            break;
        }
    }
    return shuns;
}
void printshunzi(int duni)
{
    //printf("À≥◊”£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",shunf[i],shun[i]);
        if(duni==3)
        {
            houdunf[i]=shunf[i];
            houdunp[i]=shun[i];
            
            houdun[dunii]=shunf[i];
            dunii++;
            if(shun[i]<=9)
            {
                houdun[dunii]=shun[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(shun[i]/10)+'0';
                dunii++;
                houdun[dunii]=(shun[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=shunf[i];
            zhongdunp[i]=shun[i];
            
            zhongdun[dunii]=shunf[i];
            dunii++;
            if(shun[i]<=9)
            {
                zhongdun[dunii]=shun[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(shun[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(shun[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
}

int ifsantiao()
{
    for(int i=14;i>1;i--)
    {
        if(count[i]==3)
        {
            santiaos=1;
            santiao[0]=i;
            santiao[1]=i;
            santiao[2]=i;
            int santiaoi=3;
            for(int j=2;j<15;j++)
            {
                if(j!=i&&count[j]>0)//»˝Ãıøœ∂®æÕ√ª∂‘◊”¡À£¨≤ª”√øº¬«Ã´∂‡
                {
                    santiao[santiaoi]=j;
                    santiaoi++;
                    if(santiaoi==5)
                        break;
                }
            }
            santiaoi=0;
            for(int k=0;k<3;k++)//“ÚŒ™∫˘¬´µƒ»˝’≈ø…ƒ‹±»¡ÌÕ‚¡Ω∏ˆµ•’≈¥Û£¨¡ÌÕ‚¡Ω∏ˆµ•’≈“≤≤ª÷™µ¿À≠¥Û£¨À˘“‘“™»˝÷ÿ—≠ª∑
            {
                for(int j=0;j<13;j++)
                {
                    if(santiao[santiaoi]==shunxup[j])
                    {
                        santiaof[santiaoi]=shunxuf[j];
                        santiaoi++;
                        if(santiaoi==5)
                            break;
                    }
                }
                if(santiaoi==5)
                    break;
            }
            
            break;
        }
    }
    return santiaos;
}
void printsantiao(int duni)
{
    //printf("»˝Ãı£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",santiaof[i],santiao[i]);
        if(duni==3)
        {
            houdunf[i]=santiaof[i];
            houdunp[i]=santiao[i];
            
            houdun[dunii]=santiaof[i];
            dunii++;
            if(santiao[i]<=9)
            {
                houdun[dunii]=santiao[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(santiao[i]/10)+'0';
                dunii++;
                houdun[dunii]=(santiao[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=santiaof[i];
            zhongdunp[i]=santiao[i];
            
            zhongdun[dunii]=santiaof[i];
            dunii++;
            if(santiao[i]<=9)
            {
                zhongdun[dunii]=santiao[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(santiao[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(santiao[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
}

int ifliangdui()
{
    for(int i=14;i>1;i--)
    {
        if(count[i]==2)
        {
            for(int j=2;j<15;j++)
            {
                if(count[j]==2&&j!=i)
                {
                    //liangduis=1;
                    for(int k=2;k<15;k++)
                    {
                        if(count[k]==1)
                        {
                            liangduis=1;
                            liangdui[0]=i;
                            liangdui[1]=i;
                            liangdui[2]=j;
                            liangdui[3]=j;
                            liangdui[4]=k;
                            int liangduii=0;
                            for(int kkk=0;kkk<3;kkk++)
                            {
                                for(int kk=0;kk<13;kk++)
                                {
                                    if(liangdui[liangduii]==shunxup[kk])
                                    {
                                        liangduif[liangduii]=shunxuf[kk];
                                        liangduii++;
                                        if(liangduii==5)
                                            break;
                                    }
                                }
                                if(liangduii==5)
                                    break;
                            }
                            
                            break;
                        }
                    }
                    if(liangduis==0)
                    {
                        for(int k=2;k<15;k++)
                        {
                            if(count[k]>0&&k!=i&&k!=j)
                            {
                                liangduis=1;
                                liangdui[0]=i;
                                liangdui[1]=i;
                                liangdui[2]=j;
                                liangdui[3]=j;
                                liangdui[4]=k;
                                int liangduii=0;
                                for(int kkk=0;kkk<3;kkk++)
                                {
                                    for(int kk=0;kk<13;kk++)
                                    {
                                        if(liangdui[liangduii]==shunxup[kk])
                                        {
                                            liangduif[liangduii]=shunxuf[kk];
                                            liangduii++;
                                            if(liangduii==5)
                                                break;
                                        }
                                    }
                                    if(liangduii==5)
                                        break;
                                }
                                
                                break;
                            }
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    int sums=0;
    for(int i=2;i<15;i++)
    {
        if(count[i]==2)
            sums++;
    }
    if(sums==2)
        liangduis=0;
    for(int i=14;i>1;i--)
    {
        if(count[i]==2&&count[i-1]==2)
        {
            for(int k=2;k<15;k++)
            {
                if(count[k]==1)
                {
                    liangduis=1;
                    liangdui[0]=i;
                    liangdui[1]=i;
                    liangdui[2]=i-1;
                    liangdui[3]=i-1;
                    liangdui[4]=k;
                    int liangduii=0;
                    for(int kkk=0;kkk<3;kkk++)
                    {
                        for(int kk=0;kk<13;kk++)
                        {
                            if(liangdui[liangduii]==shunxup[kk])
                            {
                                liangduif[liangduii]=shunxuf[kk];
                                liangduii++;
                                if(liangduii==5)
                                    break;
                            }
                        }
                        if(liangduii==5)
                            break;
                    }
                    
                    break;
                }
            }
            if(liangduis==0)
            {
                for(int k=2;k<15;k++)
                {
                    if(count[k]>0&&k!=i&&k!=i-1)
                    {
                        liangduis=1;
                        liangdui[0]=i;
                        liangdui[1]=i;
                        liangdui[2]=i-1;
                        liangdui[3]=i-1;
                        liangdui[4]=k;
                        int liangduii=0;
                        for(int kkk=0;kkk<3;kkk++)
                        {
                            for(int kk=0;kk<13;kk++)
                            {
                                if(liangdui[liangduii]==shunxup[kk])
                                {
                                    liangduif[liangduii]=shunxuf[kk];
                                    liangduii++;
                                    if(liangduii==5)
                                        break;
                                }
                            }
                            if(liangduii==5)
                                break;
                        }
                        
                        break;
                    }
                }
            }
            
            break;
        }
        
    }
    return liangduis;
}
void printliangdui(int duni)
{
    //printf("¡Ω∂‘£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",liangduif[i],liangdui[i]);
        if(duni==3)
        {
            houdunf[i]=liangduif[i];
            houdunp[i]=liangdui[i];
            
            houdun[dunii]=liangduif[i];
            dunii++;
            if(liangdui[i]<=9)
            {
                houdun[dunii]=liangdui[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(liangdui[i]/10)+'0';
                dunii++;
                houdun[dunii]=(liangdui[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=liangduif[i];
            zhongdunp[i]=liangdui[i];
            
            zhongdun[dunii]=liangduif[i];
            dunii++;
            if(liangdui[i]<=9)
            {
                zhongdun[dunii]=liangdui[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(liangdui[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(liangdui[i]%10)+'0';
                dunii++;
            }
        }
    }
    //printf("\n");
}

int ifyidui()
{
    yiduis=0;
    for(int i=14;i>1;i--)
    {
        if(count[i]==2)
        {
            yiduis=1;
            yidui[0]=i;
            yidui[1]=i;
            int yiduii=2;
            for(int j=2;j<15;j++)
            {
                if(count[j]==1)
                {
                    yidui[yiduii]=j;
                    yiduii++;
                }
                if(yiduii==5)
                    break;
            }
            yiduii=0;
            for(int k=0;k<5;k++)
            {
                for(int j=0;j<13;j++)
                {
                    if(yidui[yiduii]==shunxup[j])
                    {
                        yiduif[yiduii]=shunxuf[j];
                        yiduii++;
                    }
                    if(yiduii==5)
                        break;
                }
                if(yiduii==5)
                    break;
            }
            break;
        }
    }
    return yiduis;
}
void printyidui(int duni)
{
    //printf("“ª∂‘£∫");
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",yiduif[i],yidui[i]);
        if(duni==3)
        {
            houdunf[i]=yiduif[i];
            houdunp[i]=yidui[i];
            
            houdun[dunii]=yiduif[i];
            dunii++;
            if(yidui[i]<=9)
            {
                houdun[dunii]=yidui[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(yidui[i]/10)+'0';
                dunii++;
                houdun[dunii]=(yidui[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=yiduif[i];
            zhongdunp[i]=yidui[i];
            
            zhongdun[dunii]=yiduif[i];
            dunii++;
            if(yidui[i]<=9)
            {
                zhongdun[dunii]=yidui[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(yidui[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(yidui[i]%10)+'0';
                dunii++;
            }
        }
    }
}

int ifyizhang()
{
    for(int i=2;i<15;i++)
    {
        if(count[i]>1)
        {
            yizhangs=0;
            break;
        }
        if(i==14&&count[14]<2)
        {
            yizhangs=1;
            int yizhangi=0;
            for(int j=13;j>=0;j--)
            {
                if(shunxup[j]>0)
                {
                    yizhang[yizhangi]=shunxup[j];
                    yizhangf[yizhangi]=shunxuf[j];
                    yizhangi++;
                    break;
                }
            }
            for(int j=0;j<15;j++)
            {
                if(shunxup[j]>0)
                {
                    yizhang[yizhangi]=shunxup[j];
                    yizhangf[yizhangi]=shunxuf[j];
                    yizhangi++;
                    if(yizhangi==5)
                        break;
                }
            }
        }
    }
    return yizhangs;
}
void printyizhang(int duni)
{
    int dunii=0;
    for(int i=0;i<5;i++)
    {
        //printf("%c%d ",yizhangf[i],yizhang[i]);
        if(duni==3)
        {
            houdunf[i]=yizhangf[i];
            houdunp[i]=yizhang[i];
            
            houdun[dunii]=yizhangf[i];
            dunii++;
            if(yizhang[i]<=9)
            {
                houdun[dunii]=yizhang[i]+'0';
                dunii++;
            }
            else
            {
                houdun[dunii]=(yizhang[i]/10)+'0';
                dunii++;
                houdun[dunii]=(yizhang[i]%10)+'0';
                dunii++;
            }
        }
        else if(duni==2)
        {
            zhongdunf[i]=yizhangf[i];
            zhongdunp[i]=yizhang[i];
            
            zhongdun[dunii]=yizhangf[i];
            dunii++;
            if(yizhang[i]<=9)
            {
                zhongdun[dunii]=yizhang[i]+'0';
                dunii++;
            }
            else
            {
                zhongdun[dunii]=(yizhang[i]/10)+'0';
                dunii++;
                zhongdun[dunii]=(yizhang[i]%10)+'0';
                dunii++;
            }
        }
    }
}

char * cardmain(char pai[60])
{
    
    for(int i=0;i<6;i++)
        qiandun[i]=' ';
    for(int i=0;i<10;i++)
        zhongdun[i]=' ',houdun[i]=' ';
    for(int i=0;i<3;i++)
        qiandunf[i]=' ';
    for(int i=0;i<5;i++)
        zhongdunf[i]=' ',houdunf[i]=' ',yizhangf[i]=' ',thsf[i]=' ',zhaf[i]=' ',huluf[i]=' ',tonghuaf[i]=' ',shunf[i]=' ',santiaof[i]=' ',liangduif[i]=' ',yiduif[i]=' ';
    for(int i=0;i<13;i++)
        shunxuf[i]=' ',ose0[i]=' ',ose1[i]=' ',ose2[i]=' ',ose3[i]=' ';
    
    
    
    for(int i=0;i<5;i++)
        ths[i]=0,zha[i]=0,hulu[i]=0,tonghua[i]=0,shun[i]=0,santiao[i]=0,liangdui[i]=0,yidui[i]=0,yizhang[i]=0,zhongdunp[i]=0,houdunp[i]=0;
    
    for(int i=0;i<3;i++)
        qiandunp[i]=0;
    for(int i=0;i<13;i++)
        shunxup[i]=0;
    for(int i=0;i<15;i++)
        count[i]=0;
    for(int i=0;i<4;i++)
        flower[i]=0;
    
    
    
    for(int i=0;i<60;i++)
        qiandung[i]=' ',jieguo[i]=' ';
    
    
    
    thss=0,    se0=-1,se1=-1,se2=-1,se3=-1,ose0i=0,ose1i=0,ose2i=0,ose3i=0,zhas=0,zham=-1,zhad=-1,hulus=0,tonghuas=0,shuns=0,santiaos=0,liangduis=0,yiduis,yizhangs=0,qiandungi=0;
    
    
    
    
    
    
    
    int sxpi=0,sxpfi=0; //À≥–Ú≤Ÿ◊˜µƒi
    for(int i=2;i<=9;i++)
    {
        for(int j=0;j<=60;j++)
        {
            if(pai[j]==i+'0')
            {
                count[i]++;
                shunxup[sxpi]=i;
                sxpi++;
                shunxuf[sxpfi]=pai[j-1];
                sxpfi++;
                if(pai[j-1]=='#')
                    flower[0]++;
                if(pai[j-1]=='$')
                    flower[1]++;
                if(pai[j-1]=='&')
                    flower[2]++;
                if(pai[j-1]=='*')
                    flower[3]++;
            }
        }
    }
    
    for(int j=0;j<=60;j++)
    {
        if(pai[j]=='1')
        {
            count[10]++;
            shunxup[sxpi]=10;
            sxpi++;
            shunxuf[sxpfi]=pai[j-1];
            sxpfi++;
            if(pai[j-1]=='#')
                flower[0]++;
            if(pai[j-1]=='$')
                flower[1]++;
            if(pai[j-1]=='&')
                flower[2]++;
            if(pai[j-1]=='*')
                flower[3]++;
        }
    }
    
    for(int j=0;j<=60;j++)
    {
        if(pai[j]=='J')
        {
            count[11]++;
            shunxup[sxpi]=11;
            sxpi++;
            shunxuf[sxpfi]=pai[j-1];
            sxpfi++;
            if(pai[j-1]=='#')
                flower[0]++;
            if(pai[j-1]=='$')
                flower[1]++;
            if(pai[j-1]=='&')
                flower[2]++;
            if(pai[j-1]=='*')
                flower[3]++;
        }
    }
    
    for(int j=0;j<=60;j++)
    {
        if(pai[j]=='Q')
        {
            count[12]++;
            shunxup[sxpi]=12;
            sxpi++;
            shunxuf[sxpfi]=pai[j-1];
            sxpfi++;
            if(pai[j-1]=='#')
                flower[0]++;
            if(pai[j-1]=='$')
                flower[1]++;
            if(pai[j-1]=='&')
                flower[2]++;
            if(pai[j-1]=='*')
                flower[3]++;
        }
    }
    
    for(int j=0;j<=60;j++)
    {
        if(pai[j]=='K')
        {
            count[13]++;
            shunxup[sxpi]=13;
            sxpi++;
            shunxuf[sxpfi]=pai[j-1];
            sxpfi++;
            if(pai[j-1]=='#')
                flower[0]++;
            if(pai[j-1]=='$')
                flower[1]++;
            if(pai[j-1]=='&')
                flower[2]++;
            if(pai[j-1]=='*')
                flower[3]++;
        }
    }
    
    for(int j=0;j<=60;j++)
    {
        if(pai[j]=='A')
        {
            count[14]++;
            shunxup[sxpi]=14;
            sxpi++;
            shunxuf[sxpfi]=pai[j-1];
            sxpfi++;
            if(pai[j-1]=='#')
                flower[0]++;
            if(pai[j-1]=='$')
                flower[1]++;
            if(pai[j-1]=='&')
                flower[2]++;
            if(pai[j-1]=='*')
                flower[3]++;
        }
    }
    if(ifths())//Õ¨ª®À≥
    {
        printths(3);
        thss=0;
    }
    
    else if(ifzhad())//’®µØ
    {
        printzhad(3);
        zhas=0;
        //printf("weiz");
    }
    
    else if(ifhulu())//∫˘¬´
    {
        printhulu(3);
        hulus=0;
    }
    
    
    else if(iftonghua())//Õ¨ª®
    {
        printtonghua(3);
        tonghuas=0;
    }
    
    
    else if(ifshunzi())//À≥◊”
    {
        printshunzi(3);
        shuns=0;
    }
    
    else if(ifsantiao())//»˝Ãı
    {
        printsantiao(3);
        santiaos=0;
    }
    
    else if(ifliangdui())//¡Ω∂‘
    {
        printliangdui(3);
        liangduis=0;
    }
    
    else if(ifyidui())//“ª∂‘
    {
        printyidui(3);
        yiduis=0;
    }
    
    else if(ifyizhang())//“ª’≈
    {
        printyizhang(3);
        yizhangs=0;
    }
    
    
    for(int i=0;i<5;i++)
    {
        for(int j=0;j<13;j++)
        {
            if(houdunf[i]==shunxuf[j]&&houdunp[i]==shunxup[j])
            {
                if(shunxuf[j]=='#')
                    flower[0]--;
                if(shunxuf[j]=='$')
                    flower[1]--;
                if(shunxuf[j]=='&')
                    flower[2]--;
                if(shunxuf[j]=='*')
                    flower[3]--;
                
                count[shunxup[j]]--;
                
                shunxuf[j]='w';//±Ì æ√ª”–
                shunxup[j]=0;
                
            }
            
        }
    }
    //÷–∂’¥¶¿Ì
    if(ifths())//Õ¨ª®À≥
    {
        printths(2);
    }
    else if(ifzhad())//’®µØ
    {
        printzhad(2);
    }
    else if(ifhulu())//∫˘¬´
    {
        printhulu(2);
    }
    else if(iftonghua())//Õ¨ª®
    {
        printtonghua(2);
    }
    else if(ifshunzi())//À≥◊”
    {
        printshunzi(2);
    }
    else if(ifsantiao())//»˝Ãı
    {
        printsantiao(2);
    }
    else if(ifliangdui())//¡Ω∂‘
    {
        printliangdui(2);
    }
    else if(ifyidui())//“ª∂‘
    {
        printyidui(2);
    }
    else if(ifyizhang())//“ª’≈
    {
        printyizhang(2);
    }
    
    
    
    
    
    for(int i=0;i<5;i++)
    {
        for(int j=0;j<13;j++)
        {
            if(zhongdunf[i]==shunxuf[j]&&zhongdunp[i]==shunxup[j])
            {
                if(shunxuf[j]=='#')
                    flower[0]--;
                if(shunxuf[j]=='$')
                    flower[1]--;
                if(shunxuf[j]=='&')
                    flower[2]--;
                if(shunxuf[j]=='*')
                    flower[3]--;
                
                count[shunxup[j]]--;
                
                shunxuf[j]='w';//±Ì æ√ª”–
                shunxup[j]=0;
                
            }
            
        }
    }
    int qianduni=0;
    for(int i=0;i<13;i++)
    {
        if(shunxup[i]!=0)
        {
            qiandunf[qianduni]=shunxuf[i];
            qiandunp[qianduni]=shunxup[i];
            qianduni++;
        }
    }
    for(int i=0;i<3;i++)
    {
        if(qiandunp[i]<10)
        {
            qiandung[qiandungi++]=qiandunf[i];
            qiandung[qiandungi++]=qiandunp[i]+'0';
            qiandung[qiandungi++]=' ';
        }
        else if(qiandunp[i]==10)
        {
            qiandung[qiandungi++]=qiandunf[i];
            qiandung[qiandungi++]='1';
            qiandung[qiandungi++]='0';
            qiandung[qiandungi++]=' ';
        }
        else if(qiandunp[i]==11)
        {
            qiandung[qiandungi++]=qiandunf[i];
            qiandung[qiandungi++]='J';
            qiandung[qiandungi++]=' ';
        }
        else if(qiandunp[i]==12)
        {
            qiandung[qiandungi++]=qiandunf[i];
            qiandung[qiandungi++]='Q';
            qiandung[qiandungi++]=' ';
        }
        else if(qiandunp[i]==13)
        {
            qiandung[qiandungi++]=qiandunf[i];
            qiandung[qiandungi++]='K';
            qiandung[qiandungi++]=' ';
        }
        else if(qiandunp[i]==14)
        {
            qiandung[qiandungi++]=qiandunf[i];
            qiandung[qiandungi++]='A';
            qiandung[qiandungi++]=' ';
        }
        
    }
    for(int i=0;i<5;i++)
    {
        if(zhongdunp[i]<10)
        {
            qiandung[qiandungi++]=zhongdunf[i];
            qiandung[qiandungi++]=zhongdunp[i]+'0';
            qiandung[qiandungi++]=' ';
        }
        else if(zhongdunp[i]==10)
        {
            qiandung[qiandungi++]=zhongdunf[i];
            qiandung[qiandungi++]='1';
            qiandung[qiandungi++]='0';
            qiandung[qiandungi++]=' ';
        }
        else if(zhongdunp[i]==11)
        {
            qiandung[qiandungi++]=zhongdunf[i];
            qiandung[qiandungi++]='J';
            qiandung[qiandungi++]=' ';
        }
        else if(zhongdunp[i]==12)
        {
            qiandung[qiandungi++]=zhongdunf[i];
            qiandung[qiandungi++]='Q';
            qiandung[qiandungi++]=' ';
        }
        else if(zhongdunp[i]==13)
        {
            qiandung[qiandungi++]=zhongdunf[i];
            qiandung[qiandungi++]='K';
            qiandung[qiandungi++]=' ';
        }
        else if(zhongdunp[i]==14)
        {
            qiandung[qiandungi++]=zhongdunf[i];
            qiandung[qiandungi++]='A';
            qiandung[qiandungi++]=' ';
        }
        
    }
    for(int i=0;i<5;i++)
    {
        if(houdunp[i]<10)
        {
            qiandung[qiandungi++]=houdunf[i];
            qiandung[qiandungi++]=houdunp[i]+'0';
            qiandung[qiandungi++]=' ';
        }
        else if(houdunp[i]==10)
        {
            qiandung[qiandungi++]=houdunf[i];
            qiandung[qiandungi++]='1';
            qiandung[qiandungi++]='0';
            qiandung[qiandungi++]=' ';
        }
        else if(houdunp[i]==11)
        {
            qiandung[qiandungi++]=houdunf[i];
            qiandung[qiandungi++]='J';
            qiandung[qiandungi++]=' ';
        }
        else if(houdunp[i]==12)
        {
            qiandung[qiandungi++]=houdunf[i];
            qiandung[qiandungi++]='Q';
            qiandung[qiandungi++]=' ';
        }
        else if(houdunp[i]==13)
        {
            qiandung[qiandungi++]=houdunf[i];
            qiandung[qiandungi++]='K';
            qiandung[qiandungi++]=' ';
        }
        else if(houdunp[i]==14)
        {
            qiandung[qiandungi++]=houdunf[i];
            qiandung[qiandungi++]='A';
            qiandung[qiandungi++]=' ';
        }
        
    }
    return qiandung;
}

