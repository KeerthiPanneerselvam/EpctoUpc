//
//  NewprjTests.swift
//  NewprjTests
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import XCTest
@testable import Newprj

class NewprjTests: XCTestCase {
    
    let vcc = EpctoUpc()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //EPC correct Length
    func testCheckcorrectEpcLengthTrue() {
        let v4 = "3074257BF714E4000001A85A"
        XCTAssertTrue(vcc.CheckcorrectEpcLength(v4))
        
    }
    
    func testCheckcorrectEpcLengthFalse() {
        let v7 = "3074257BF714E400000185A"
        XCTAssertFalse(vcc.CheckcorrectEpcLength(v7))
    }
    
    //EPC is hexadecimal
    func testCheckforhexstringtrue() {
        let v5 = "3034257BF400B7800004CB2F"
        XCTAssertTrue(vcc.checkforhexString(v5))
    }
    
    func testCheckforhexstringfalse() {
        let v6 = "3074257BF71pgt4E4000001A85"
        XCTAssertFalse(vcc.checkforhexString(v6))
    }
    
    func testEpctoUpcEqual() {
        let v1 = "3034257BF400B7800004CB2F"
        XCTAssertEqual(vcc.epctoupc(v1), "06141410007345")
    }
    
    func testEpctoUpcnil() {
        let v2 = "307F257BF7194E4000001A85"
        XCTAssertNil(vcc.epctoupc(v2))
        let v3 = "30767F6FF7194E4000001A85"
        XCTAssertNil(vcc.epctoupc(v3))
    }
    
    func testbintoInt() {
        let v9 = "101"
        XCTAssertEqual(vcc.bintoInt(v9), 5)
    }
    
    func testhextobin() {
        let v10 = "101101111000000000000000000001001100101100101111"
        XCTAssertEqual(vcc.hextobin("B7800004CB2F"), v10)
    }
    
    

}
