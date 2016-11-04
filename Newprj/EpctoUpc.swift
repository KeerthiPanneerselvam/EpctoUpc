//
//  EpctoUpc.swift
//  Newprj
//
//  Created by Admin on 21/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class EpctoUpc
{
    
    func CheckcorrectEpcLength(epc:String)->Bool
    {
        print("check for correct epc length")
        if epc.characters.count != 24
        {
            return false
        }
        return true
    }
    
    func checkforhexString(str:String)->Bool
    {
        print("check for correct epc by hex")
        let specialchar = "0123456789abcdefABCDEF"
        let charset = NSCharacterSet(charactersInString: specialchar)
        let stringOne = str
        let stringOneResult = stringOne.rangeOfCharacterFromSet(charset.invertedSet) //!= nil
        print("stringOneResult: \(stringOneResult)")
        if stringOneResult != nil
        {
            return false
        }
        return true
    }
    
    func epctoupc(epc:String) -> String?
    {
        var itemRefBits:[Int] = [4,7,10,14,17,20,24]
        var companyPrefixValues :[Int] = [40, 37, 34,30, 27, 24, 20];
        let binEpc = hextobin(epc)
        //to get the partition value 3 bits
        let epcSubStr = substr(binEpc,range: 11,num: 3)
        //converting it to a decimal
        let partitionvalue = bintoInt(epcSubStr)
        //there are oly 6 partions based on company prefix and Item reference
        if partitionvalue == 7
        {
            return nil
        }
        //check for number of bits in company prefix - depends upon the company
        let bits = companyPrefixValues[partitionvalue]
        //extract the company prefix and convert it to decimal
        let companyPrefixValue = bintoInt(substr(binEpc, range: 14, num:bits))
        
        if companyPrefixValue > Int(pow(Double(10), Double(12-partitionvalue)))
        {
            return nil
        }
        //padding the company prefix
        var companyPrefix = String(companyPrefixValue)
        print("Company prefix" , (companyPrefix))
        let pad = "000000000000"
        let value = pad.characters.count - partitionvalue
        companyPrefix = substr1(pad, range1: companyPrefix.characters.count, num: value-1) + companyPrefix
        print("Company prefix" , (companyPrefix))
        let res = substr(binEpc, range: 14+bits , num: itemRefBits[partitionvalue])
        let objectclassValue = bintoInt(res)
        print("objectclassValue" , (objectclassValue))
        var objectclass = String(objectclassValue)
        let pad1 = "0000000000000000"
        objectclass = substr(pad1, range: 0, num: (pad1.characters.count - objectclass.characters.count)) + objectclass
        print("Object Class" , (objectclass))
        let itemcode = substr1(objectclass, range1: 16 - partitionvalue - 1, num: objectclass.characters.count-1)
        print("Item Code" , (itemcode))
        let d = calculatecheckdigit("0614141000734")
        let upc1 = companyPrefix+itemcode+String(d);
        return upc1
    }
    
    func substr(be:String,range:Int,num:Int)->String
    {
        let str1 = be
        let str2 = str1 as NSString
        let my = str2.substringWithRange(NSRange(location: range, length: num))
        print(my)
        return my
    }
    
    func substr1(str3:String,range1:Int,num:Int)->String
    {
        let v5 = str3[str3.startIndex.advancedBy(range1)...str3.startIndex.advancedBy(num)]
        return v5
    }
    
    func bintoInt(str3:String)->Int
    {
        let bin = str3
        let num = Int(bin,radix:2)
        return num!
        
    }
    func hextobin(str11:String)->String
    {
        let count = str11.characters.count
        let mid = count/2
        let s1 = str11[str11.startIndex...str11.startIndex.advancedBy(mid)]
        let s2 = str11[str11.startIndex.advancedBy(mid+1)...str11.endIndex.advancedBy(-1)]
        print(s1)
        print(s2)
        let r1 = hexToBinaryConversion(s1)
        let r2 = hexToBinaryConversion(s2)
        let final = r1 + r2
        print(final)
        return final
    }
    
    func hexToBinaryConversion(epc1:String) -> String
    {
        var extra :String = ""
        let epc2 = epc1
        let len1 = epc2.characters.count * 4
        var b4 = String(Int(epc2,radix: 16)!,radix:2)
        let len2 = b4.characters.count
        if len2 != len1
        {
            let l3 = abs(len2-len1)
            for _ in 1...l3{
                extra = extra + "0"
            }
            b4 = extra + b4
        }
        print(b4)
        return b4
    }
    
    func calculatecheckdigit(upc:String)->Int
    {
        let upc1 = upc
        var even = 0
        var odd = 0
        var upc2 = [Int]()
        for i in upc1.characters {
            let someString = String(i)
            if let someInt = Int(someString) {
                upc2 += [someInt]
            }
        }
        for i in 0...upc2.count-1
        {
            if i%2 == 0
            {
                even = even + upc2[i]
            }
            else
            {
                odd = odd + upc2[i]
            }
        }
        let oddr = odd * 3
        let final = oddr + even
        let g = final % 10
        let checkdigit = 10 - g
        
        return checkdigit
    }

    
}