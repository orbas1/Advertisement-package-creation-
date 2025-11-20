<?php

namespace Advertisement\Http\Controllers;

use Advertisement\Http\Requests\CreativeRequest;
use Advertisement\Models\Creative;
use Illuminate\Http\JsonResponse;

class CreativeController
{
    public function store(CreativeRequest $request): JsonResponse
    {
        $creative = Creative::create($request->validated());

        return response()->json($creative, 201);
    }

    public function update(CreativeRequest $request, Creative $creative): JsonResponse
    {
        $creative->update($request->validated());

        return response()->json($creative);
    }
}
