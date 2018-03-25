@import QuickLook;
@import OSAKit;

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options) {
    NSDictionary *scriptErrorInfo;
    OSAScript *script = [[OSAScript alloc] initWithContentsOfURL:(__bridge NSURL *)url error:&scriptErrorInfo];
    if (scriptErrorInfo) {
        return noErr;
    }

    NSAttributedString *richTextSource = script.richTextSource;
    NSData *richTextDataRepresentation = [richTextSource RTFFromRange:NSMakeRange(0, richTextSource.length) documentAttributes:@{}];

    QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)richTextDataRepresentation, kUTTypeRTF, NULL);
    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview) {
    // Implement only if supported
}
