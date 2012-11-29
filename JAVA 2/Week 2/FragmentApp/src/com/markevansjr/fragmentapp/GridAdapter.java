package com.markevansjr.fragmentapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class GridAdapter extends BaseAdapter {

    private class ViewHolder {
        public ImageView imageView;
        public TextView  textView;
    }
    
    private FoodModel[] mLocations;
    private LayoutInflater  mInflater;
    
    public GridAdapter(Context context, FoodModel[] locations) {
        mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        mLocations = locations;
    }
    
    @Override
    public int getCount() {
        if (mLocations != null) {
            return mLocations.length;
        }
        
        return 0;
    }

    @Override
    public Object getItem(int position) {
        if (mLocations != null && position >= 0 && position < getCount()) {
            return mLocations[position];
        }
        
        return null;
    }

    @Override
    public long getItemId(int position) {
        if (mLocations != null && position >= 0 && position < getCount()) {
            return mLocations[position].id;
        }
        
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        
        View       view = convertView;
        ViewHolder viewHolder;
        
        if (view == null) {
            view = mInflater.inflate(R.layout.grid_item, parent, false);
            
            viewHolder = new ViewHolder();
            viewHolder.imageView = (ImageView) view.findViewById(R.id.grid_image);
            viewHolder.textView  = (TextView) view.findViewById(R.id.grid_label);
            
            view.setTag(viewHolder);
        }
        else {
            viewHolder = (ViewHolder) view.getTag();
        }
        
        FoodModel locationModel = mLocations[position];
        
        viewHolder.imageView.setImageResource(locationModel.picture);
        viewHolder.textView.setText(locationModel.name);
        
        return view;
    }

}
