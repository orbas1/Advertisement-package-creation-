<?php

namespace Advertisement\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Campaign extends Model
{
    use HasFactory;

    protected $fillable = [
        'advertiser_id',
        'title',
        'start_date',
        'end_date',
        'budget',
        'bidding',
        'status',
        'spend',
        'placement',
        'objective',
        'targeting_reach',
        'approval_state',
    ];

    protected $casts = [
        'start_date' => 'datetime',
        'end_date' => 'datetime',
    ];

    public function advertiser()
    {
        return $this->belongsTo(Advertiser::class);
    }

    public function adGroups()
    {
        return $this->hasMany(AdGroup::class);
    }

    public function creatives()
    {
        return $this->hasMany(Creative::class);
    }

    public function targetingRules()
    {
        return $this->hasMany(TargetingRule::class);
    }

    public function metrics()
    {
        return $this->hasMany(Metric::class);
    }

    public function forecasts()
    {
        return $this->hasMany(Forecast::class);
    }
}
