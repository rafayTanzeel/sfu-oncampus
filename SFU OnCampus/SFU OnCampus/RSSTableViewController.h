//
//  RSSTableViewController.h
//  RSSSSSSS
//
//  Created by Rafay Tanzeel on 2015-03-15.
//  Copyright (c) 2015 Rafay Tanzeel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSTableViewController : UITableViewController<NSXMLParserDelegate>

@property (nonatomic, strong) NSURL *rssUrl;
@property (nonatomic, strong) NSMutableArray *feeds;
@property (nonatomic, strong) NSMutableDictionary *entry;
@property (nonatomic, strong) NSMutableString *currentElement;
@property (nonatomic, strong) NSMutableString *currentTitle;
@property (nonatomic, strong) NSMutableString *currentSummary;
@property (nonatomic, strong) NSMutableString *currentLink;
@property (nonatomic, strong) NSMutableString *currentPublished;

@end
