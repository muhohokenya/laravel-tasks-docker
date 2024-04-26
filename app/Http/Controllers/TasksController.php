<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;

class TasksController extends Controller
{
    public function save(Request $request): JsonResponse
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

    public function node(): JsonResponse
    {
        $host = gethostname();

        $ip = gethostbyname($host);
        return Response::json([
            'host'=>$host
        ]);
    }

}
