<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;

class TasksController extends Controller
{
    public function save(Request $request): \Illuminate\Http\JsonResponse
    {
        Task::query()->create([
            'name'=>$request->get('name')
        ]);

        return Response::json(['message'=>'task created']);
    }
    public function get(): array
    {
        return Task::query()->get()->all();
    }

}
