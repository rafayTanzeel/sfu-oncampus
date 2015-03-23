//
//  SFUTransitTableViewController.h
//  OnCampus
//  Group 10
//  Nikhil Gaba, Abram Wiebe, Rafay Tanzeel, Kevin Grant, Sunny Chowdhury
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//
// Changelog: https://github.com/nikhilgaba/sfu-oncampus
//
//
//
// Presently no known bugs

#import <UIKit/UIKit.h>

@interface RSSTableViewController : UITableViewController<NSXMLParserDelegate>

@property (nonatomic, strong) NSURL *rssUrl; //Gets the URL from the selected cell of RSSMainTableViewController
@property (nonatomic, strong) NSMutableArray *feeds; //Stores all the cells in the feeds mutable array
@property (nonatomic, strong) NSMutableDictionary *entry; //Acts as an element to each item of feeds array
@property (nonatomic, strong) NSMutableString *currentElement; //Acts as a buffer to store the current element being parsed
@property (nonatomic, strong) NSMutableString *currentTitle; //Stores te current title that was parse
@property (nonatomic, strong) NSMutableString *currentSummary; //Stores the current summary that was parse
@property (nonatomic, strong) NSMutableString *currentLink; //Stores the current link that was parse
@property (nonatomic, strong) NSMutableString *currentPublished; //Stores the published date that was parse

@end
