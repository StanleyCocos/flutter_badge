package com.addcn859111.badge.flutter_push_badge.impl;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;

import java.util.Arrays;
import java.util.List;


import com.addcn859111.badge.flutter_push_badge.Badger;
import com.addcn859111.badge.flutter_push_badge.ShortcutBadgeException;
import com.addcn859111.badge.flutter_push_badge.util.BroadcastHelper;

/**
 * @author Gernot Pansy
 */
public class ApexHomeBadger implements Badger {

    private static final String INTENT_UPDATE_COUNTER = "com.anddoes.launcher.COUNTER_CHANGED";
    private static final String PACKAGENAME = "package";
    private static final String COUNT = "count";
    private static final String CLASS = "class";

    @Override
    public void executeBadge(Context context, ComponentName componentName, int badgeCount) throws ShortcutBadgeException {
        Intent intent = new Intent(INTENT_UPDATE_COUNTER);
        intent.putExtra(PACKAGENAME, componentName.getPackageName());
        intent.putExtra(COUNT, badgeCount);
        intent.putExtra(CLASS, componentName.getClassName());

        BroadcastHelper.sendIntentExplicitly(context, intent);
    }

    @Override
    public List<String> getSupportLaunchers() {
        return Arrays.asList("com.anddoes.launcher");
    }
}
