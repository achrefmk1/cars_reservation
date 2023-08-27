<?php

namespace App\Http\Controllers;

use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Mockery\Undefined;

class AuthAPIController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);
        if (auth()->attempt($credentials)) {
            $user = Auth::user();
            $user['token'] = $user->createToken('Laravelia')->accessToken;
            return response()->json([
                'user' => $user
            ], 200);
        }
        return response()->json([
            'message' => 'Invalid credentials'
        ], 402);
    }

    public function register(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:6',
            ]);

            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'role' => $request->role !== '' ? $request->role : "user",
                'password' => Hash::make($request->password),
            ]);

            return response()->json([
                'error' => false,
                'message' => 'User created successfully',
                'user' => $user
            ]);
        } catch (Exception $e) {
            Log::critical('api register : ' . $e->getMessage());
            return response()->json([
                'error' => true,
                'message' => $request->role,
            ], 402);
        }
    }

    public function update(Request $request, User $user)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255',
            ]);



            $user->name = $request->name;
            $user->email = $request->email;
            $user->role = $request->role;
            $user->phone = $request->phone;

            if ($request->password !== '' && $request->password !== null) {
                $user->password = Hash::make($request->password);
            }

            Log::critical('role' . $user);
            $user->save();

            return response()->json([
                'error' => false,
                'message' => 'User updated successfully',
                'user' => $user
            ]);
        } catch (Exception $e) {
            Log::critical('api update user : ' . $e->getMessage());
            return response()->json([
                'error' => true,
                'message' => $e->getMessage(),
            ]);
        }
    }

    public function toggleStatus(User $user)
    {
        try {
            $user->isEnabled = $user->isEnabled === 'yes' ? 'no' : 'yes';
            $user->save();

            return response()->json([
                'error' => false,
                'message' => 'User updated successfully',
                'user' => $user
            ]);
        } catch (Exception $e) {
            Log::critical('api update user : ' . $e->getMessage());
            return response()->json([
                'error' => true,
                'message' => $e->getMessage(),
            ]);
        }
    }

    public function logout()
    {
        Auth::user()->tokens()->delete();
        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }

    public function index()
    {
        return response()->json([
            'data' => User::all()
        ]);
    }
}
